import 'package:test/test.dart';
import '../lib/task_model.dart';
import '../lib/task_repository.dart';
import 'test_helper.dart';

void main() {
  setUp(() => nettoyerFichierTest());
  tearDown(() => nettoyerFichierTest());

  test('Test 5 : Persistance locale et rechargement de données JSON', () {
    // CORRECTION ICI : "repoInitial" en un seul mot, sans espace
    final repoInitial = creerRepoTest();
    final urgent = UrgentTask(id: '5', titre: 'Corriger Bug Production');
    
    repoInitial.ajouter(urgent);

    final secondRepo = TaskRepository(cheminFichier: testFile);
    secondRepo.charger();

    expect(secondRepo.lister().length, equals(1));
    expect(secondRepo.lister().first.type, equals('Urgent'));
    expect(secondRepo.lister().first.priorite, equals(Priorite.high));
  });
}
