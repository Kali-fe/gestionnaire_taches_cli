import 'package:test/test.dart';
import '../lib/task_model.dart';
import 'test_helper.dart';

void main() {
  setUp(() => nettoyerFichierTest());
  tearDown(() => nettoyerFichierTest());

  test('Test 1 : Ajouter une tâche valide incrémente la liste', () {
    final repo = creerRepoTest();
    final t = StandardTask(id: '1', titre: 'Acheter du pain', priorite: Priorite.low);
    
    repo.ajouter(t);
    
    expect(repo.lister().length, equals(1));
    expect(repo.lister().first.titre, equals('Acheter du pain'));
  });
}
