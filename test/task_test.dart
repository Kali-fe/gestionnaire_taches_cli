import 'dart:io';
import 'package:test/test.dart';
import '../lib/task_model.dart';
import '../lib/task_repository.dart';

void main() {
  const testFile = 'taches_test.json';
  late TaskRepository repo;

  setUp(() {
    repo = TaskRepository(cheminFichier: testFile);
  });

  tearDown(() {
    final file = File(testFile);
    if (file.existsSync()) {
      file.deleteSync();
    }
  });

  test('Test 1 : Ajouter une tâche valide incrémente la liste', () {
    final t = StandardTask(id: '1', titre: 'Acheter du pain', priorite: Priorite.low);
    repo.ajouter(t);
    expect(repo.lister().length, equals(1));
    expect(repo.lister().first.titre, equals('Acheter du pain'));
  });

  test('Test 2 : Lever une exception personnalisée si le titre est vide', () {
    final t = StandardTask(id: '2', titre: '   ', priorite: Priorite.high);
    expect(() => repo.ajouter(t), throwsA(isA<TaskException>()));
  });

  test('Test 3 : Marquer une tâche existante comme complétée', () {
    final t = StandardTask(id: '3', titre: 'Coder en Dart', priorite: Priorite.medium);
    repo.ajouter(t);
    repo.marquerCommeTerminee('3');
    expect(repo.lister().first.estTerminee, isTrue);
  });

  test('Test 4 : Supprimer une tâche réduit la taille du dépôt', () {
    final t = StandardTask(id: '4', titre: 'Nettoyer le bureau', priorite: Priorite.low);
    repo.ajouter(t);
    repo.supprimer('4');
    expect(repo.lister(), isEmpty);
  });

  test('Test 5 : Persistance locale et rechargement de données JSON', () {
    final urgent = UrgentTask(id: '5', titre: 'Corriger Bug Production');
    repo.ajouter(urgent); // Sauvegarde automatique

    final secondRepo = TaskRepository(cheminFichier: testFile);
    secondRepo.charger();

    expect(secondRepo.lister().length, equals(1));
    expect(secondRepo.lister().first.type, equals('Urgent'));
    expect(secondRepo.lister().first.priorite, equals(Priorite.high));
  });
}
