import 'dart:io';
import '../lib/task_model.dart';
import '../lib/task_repository.dart';

void main() {
  final repo = TaskRepository();

  try {
    repo.charger();
  } catch (e) {
    print(e);
  }

  print("=== BIENVENUE DANS VOTRE GESTIONNAIRE DE TÂCHES CLI ===");

  while (true) {
    print("\nMenu principal :");
    print("1. Ajouter une tâche");
    print("2. Lister toutes les tâches");
    print("3. Marquer une tâche comme terminée");
    print("4. Supprimer une tâche");
    print("5. Quitter");
    stdout.write("Sélectionnez une option (1-5) : ");

    String? choix = stdin.readLineSync();

    switch (choix) {
      case '1':
        ajouterTacheInterface(repo);
        break;
      case '2':
        listerTachesInterface(repo);
        break;
      case '3':
        marquerTacheInterface(repo);
        break;
      case '4':
        supprimerTacheInterface(repo);
        break;
      case '5':
        print("Au revoir !");
        exit(0);
      default:
        print("Option invalide. Veuillez réessayer.");
    }
  }
}

void ajouterTacheInterface(TaskRepository repo) {
  stdout.write("\nTitre de la tâche : ");
  String titre = stdin.readLineSync() ?? "";

  print("Type de tâche : 1. Standard  2. Urgente");
  String typeChoix = stdin.readLineSync() ?? "1";

  stdout.write("Date limite optionnelle (AAAA-MM-JJ) ou Entrée pour aucune : ");
  String dateStr = stdin.readLineSync() ?? "";
  DateTime? dateLimite = dateStr.isNotEmpty ? DateTime.tryParse(dateStr) : null;

  String id = DateTime.now().millisecondsSinceEpoch.toString().substring(7);

  try {
    if (typeChoix == '2') {
      repo.ajouter(UrgentTask(id: id, titre: titre, dateLimite: dateLimite));
      print("Tâche urgente ajoutée avec succès !");
    } else {
      print("Priorité : 1. Low  2. Medium  3. High");
      String prioChoix = stdin.readLineSync() ?? "1";
      Priorite prio = prioChoix == '2'
          ? Priorite.medium
          : (prioChoix == '3' ? Priorite.high : Priorite.low);

      repo.ajouter(StandardTask(id: id, titre: titre, priorite: prio, dateLimite: dateLimite));
      print("Tâche standard ajoutée avec succès !");
    }
  } catch (e) {
    print(e);
  }
}

void listerTachesInterface(TaskRepository repo) {
  print("\nTri : 1. Aucun  2. Par Priorité  3. Par Date Limite");
  String triChoix = stdin.readLineSync() ?? "1";

  List<Task> liste;
  if (triChoix == '2') {
    liste = repo.listerTrieParPriorite();
  } else if (triChoix == '3') {
    liste = repo.listerTrieParDate();
  } else {
    liste = repo.lister();
  }

  if (liste.isEmpty) {
    print("Aucune tâche enregistrée.");
    return;
  }

  print("\n--- LISTE DES TÂCHES ---");
  for (var t in liste) {
    String statut = t.estTerminee ? "[✔]" : "[ ]";
    String dateStr = t.dateLimite != null
        ? " (Échéance: ${t.dateLimite!.toIso8601String().split('T')[0]})"
        : "";
    String infoUrgence = t is UrgentTask
        ? " [URGENT: ${t.notesUrgence}]"
        : " [Priorité: ${t.priorite.name}]";
    print("$statut ID: ${t.id} | ${t.titre}$infoUrgence$dateStr");
  }
}

void marquerTacheInterface(TaskRepository repo) {
  stdout.write("\nEntrez l'ID de la tâche terminée : ");
  String id = stdin.readLineSync() ?? "";
  try {
    repo.marquerCommeTerminee(id);
    print("Statut mis à jour !");
  } catch (e) {
    print(e);
  }
}

void supprimerTacheInterface(TaskRepository repo) {
  stdout.write("\nEntrez l'ID de la tâche à supprimer : ");
  String id = stdin.readLineSync() ?? "";
  try {
    repo.supprimer(id);
    print("Tâche supprimée avec succès.");
  } catch (e) {
    print(e);
  }
}
