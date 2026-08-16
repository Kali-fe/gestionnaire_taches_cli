import 'package:test/test.dart';
import '../lib/task_model.dart';
import '../lib/task_repository.dart';
import 'test_helper.dart';

void main() {
  setUp(() => nettoyerFichierTest());
  tearDown(() => nettoyerFichierTest());

  test('Test 2 : Lever une exception personnalisée si le titre est vide', () {
    final repo = creerRepoTest();
    final t = StandardTask(id: '2', titre: '   ', priorite: Priorite.high);
    
    expect(() => repo.ajouter(t), throwsA(isA<TaskException>()));
  });
}
