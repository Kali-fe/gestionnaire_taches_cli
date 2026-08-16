import 'package:test/test.dart';
import '../lib/task_model.dart';
import 'test_helper.dart';

void main() {
  setUp(() => nettoyerFichierTest());
  tearDown(() => nettoyerFichierTest());

  test('Test 4 : Supprimer une tâche réduit la taille du dépôt', () {
    final repo = creerRepoTest();
    final t = StandardTask(id: '4', titre: 'Nettoyer le bureau', priorite: Priorite.low);
    
    repo.ajouter(t);
    repo.supprimer('4');
    
    expect(repo.lister(), isEmpty);
  });
}
