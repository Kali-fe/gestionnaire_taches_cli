# Gestionnaire de Tâches CLI - Dart Pur

Bienvenue dans l'application de gestion de tâches en ligne de commande (CLI) écrite en Dart. Ce projet a été développé dans le but de valider des compétences avancées en programmation orientée objet (POO), en manipulation de flux de données (JSON), en architecture générique et en tests unitaires automatisés.

---

##  Fonctionnalités Majeures

*   **Gestion complète des tâches (CRUD) :** Ajout de tâches standards ou urgentes, marquage comme terminé, et suppression.
*   **Système de Tri intelligent :** Visualisation de la liste des tâches par ordre chronologique (date limite) ou par niveau d'importance (priorité).
*   **Persistance locale (JSON) :** Sauvegarde automatique des données dans un fichier local dès qu'une modification est effectuée. Chargement automatique au démarrage.
*   **Architecture robuste :** Gestion centralisée des erreurs via des exceptions personnalisées, utilisation de dépôts génériques et respect des principes de l'encapsulation.

---

## Architecture & Concepts Clés Validés

L'application démontre la maîtrise des concepts suivants :
1.  **Classes abstraites & Héritage :** Classe de base `Task` déclinée en `StandardTask` (priorité variable) et `UrgentTask` (priorité forcée à *High* avec notes d'urgence).
2.  **Interfaces :** Implémentation de l'interface `Serializable` pour structurer la conversion des objets en formats compatibles JSON.
3.  **Génériques :** Définition d'un contrat de stockage réutilisable `Repository<T>` limitant les opérations aux entités de type `Task`.
4.  **Null Safety :** Utilisation rigoureuse des types optionnels (`DateTime?`, `String?`) et opérateurs de coalescence (`??`) pour éviter les plantages.

---

##  Structure du Projet (Mise à jour : Architecture de Tests Modulaire)

```text
├── bin/
│   └── main.dart            # Point d'entrée de l'application (Menu CLI)
├── lib/
│   ├── task_model.dart      # Modèles de données, Abstraction et Interfaces
│   └── task_repository.dart # Dépôt générique, gestion JSON et Exceptions
├── test/
│   ├── test_helper.dart     # Centralisation du cycle de vie du fichier de test
│   ├── task_ajout_test.dart        # Test 1 : Validation de l'ajout
│   ├── task_validation_test.dart   # Test 2 : Saisie de titre vide
│   ├── task_termine_test.dart      # Test 3 : Changement de statut (complété)
│   ├── task_suppression_test.dart  # Test 4 : Suppression par identifiant
│   └── task_persistance_test.dart  # Test 5 : Cycle d'encodage/décodage JSON
├── pubspec.yaml             # Gestionnaire de dépendances du projet
└── taches.json              # Fichier de données généré à l'exécution
```

---

##  Prérequis & Installation

### 1. Installer le SDK Dart
Assurez-vous que Dart est installé sur votre machine. Vous pouvez vérifier sa présence en exécutant dans votre terminal :
```bash
dart --version
```

### 2. Configurer le projet
Placez-vous à la racine du dossier du projet et installez les dépendances nécessaires (notamment le package officiel `test`) spécifiées dans le fichier `pubspec.yaml` :
```bash
dart pub get
```

---

##  Mode d'Emploi de l'Application (CLI)

Pour lancer le gestionnaire de tâches et interagir avec le menu dans votre console, exécutez la commande suivante :

```bash
dart run bin/main.dart
```

### Navigation dans le menu :
*   **Option 1 (Ajouter) :** Vous serez invité à saisir le titre. Si vous choisissez une tâche standard, vous pourrez définir son niveau de priorité (`low`, `medium`, `high`). Une date limite optionnelle au format `AAAA-MM-JJ` peut être ajoutée.
*   **Option 2 (Lister) :** Permet d'afficher toutes les tâches actives et passées. Un sous-menu vous propose de trier instantanément l'affichage selon vos préférences.
*   **Option 3 (Terminer) :** Renseignez l'identifiant (ID) unique affiché à côté de la tâche pour la marquer d'une coche de validation `[✔]`.
*   **Option 4 (Supprimer) :** Renseignez l'ID pour retirer définitivement la tâche de la liste et du fichier de sauvegarde.

---

##  Exécution de la Suite de Tests

Grâce à notre architecture modulaire, la suite de tests est répartie dans plusieurs fichiers indépendants mais connectés via un utilitaire commun (`test_helper.dart`). Cet utilitaire garantit l'isolation de chaque scénario en nettoyant l'environnement de stockage de manière transparente.

### Exécuter l'intégralité des tests
Pour lancer tous les fichiers de tests unitaires présents dans le dossier `test/` de manière séquentielle, utilisez la commande globale :
```bash
dart test -j 1

```

### Exécuter un seul fichier de test spécifique
Si vous souhaitez isoler vos vérifications sur un seul module pendant votre développement, vous pouvez cibler directement le fichier souhaité. Exemples :
```bash
dart test test/task_ajout_test.dart
dart test test/task_validation_test.dart
```
