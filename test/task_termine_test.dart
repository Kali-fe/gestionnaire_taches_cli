import 'package:test/test.dart';
import '../lib/task_model.dart';
import 'test_helper.dart';

void main() {
  setUp(() => nettoyerFichierTest());
  tearDown(() => nettoyerFichierTest());

  test('Test 3 : Marquer une tâche existante comme complétée', () {
    final repo = creerRepoTest();
    final t = StandardTask(id: '3', titre: 'Coder en Dart', priorite: Priorite.medium);
    
    repo.ajouter(t);
    repo.marquerCommeTerminee('3');
    
    expect(repo.lister().first.estTerminee, isTrue);
  });
}
