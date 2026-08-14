import 'dart:convert';
import 'dart:io';
import 'task_model.dart';

// Exception personnalisée
class TaskException implements Exception {
  final String message;
  TaskException(this.message);
  @override
  String toString() => "Erreur Gestion Tâches: $message";
}

// Interface pour le dépôt générique
abstract class Repository<T> {
  void ajouter(T item);
  List<T> lister();
  void supprimer(String id);
  void sauvegarder();
  void charger();
}

// Implémentation concrète avec Génériques <T extends Task>
class TaskRepository implements Repository<Task> {
  final String cheminFichier;
  List<Task> _taches = [];

  TaskRepository({this.cheminFichier = 'taches.json'});

  @override
  void ajouter(Task item) {
    if (item.titre.trim().isEmpty) {
      throw TaskException("Le titre de la tâche ne peut pas être vide.");
    }
    _taches.add(item);
    sauvegarder();
  }

  @override
  List<Task> lister() => List.unmodifiable(_taches);

  List<Task> listerTrieParPriorite() {
    var copie = List<Task>.from(_taches);
    copie.sort((a, b) => b.priorite.index.compareTo(a.priorite.index));
    return copie;
  }

  List<Task> listerTrieParDate() {
    var copie = List<Task>.from(_taches);
    copie.sort((a, b) {
      if (a.dateLimite == null) return 1;
      if (b.dateLimite == null) return -1;
      return a.dateLimite!.compareTo(b.dateLimite!);
    });
    return copie;
  }

  void marquerCommeTerminee(String id) {
    var index = _taches.indexWhere((t) => t.id == id);
    if (index == -1) throw TaskException("Tâche introuvable avec l'ID: $id");
    _taches[index].estTerminee = true;
    sauvegarder();
  }

  @override
  void supprimer(String id) {
    var index = _taches.indexWhere((t) => t.id == id);
    if (index == -1) throw TaskException("Impossible de supprimer. ID introuvable.");
    _taches.removeAt(index);
    sauvegarder();
  }

  @override
  void sauvegarder() {
    try {
      final fichier = File(cheminFichier);
      final jsonList = _taches.map((t) => t.toJson()).toList();
      fichier.writeAsStringSync(jsonEncode(jsonList));
    } catch (e) {
      throw TaskException("Échec de la sauvegarde des données : $e");
    }
  }

  @override
  void charger() {
    try {
      final fichier = File(cheminFichier);
      if (!fichier.existsSync()) return;

      final contenu = fichier.readAsStringSync();
      if (contenu.trim().isEmpty) return;

      final List<dynamic> jsonList = jsonDecode(contenu);
      _taches = jsonList.map<Task>((json) {
        if (json['type'] == 'Urgent') {
          return UrgentTask.fromJson(json);
        } else {
          return StandardTask.fromJson(json);
        }
      }).toList();
    } catch (e) {
      throw TaskException("Échec du chargement du fichier JSON : $e");
    }
  }
}
