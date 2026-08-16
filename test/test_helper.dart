import 'dart:io';
import '../lib/task_repository.dart';

const testFile = 'taches_test.json';

TaskRepository creerRepoTest() {
  return TaskRepository(cheminFichier: testFile);
}

void nettoyerFichierTest() {
  final file = File(testFile);
  if (file.existsSync()) {
    file.deleteSync();
  }
}
