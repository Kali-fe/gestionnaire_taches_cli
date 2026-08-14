# Gestionnaire de Tâches CLI - Dart Pur

Bienvenue dans l'application de gestion de tâches en ligne de commande (CLI) écrite en Dart. Ce projet a été développé dans le but de valider des compétences avancées en programmation orientée objet (POO), en manipulation de flux de données (JSON), en architecture générique et en tests unitaires automatisés.

---

## 🚀 Fonctionnalités Majeures

*   **Gestion complète des tâches (CRUD) :** Ajout de tâches standards ou urgentes, marquage comme terminé, et suppression.
*   **Système de Tri intelligent :** Visualisation de la liste des tâches par ordre chronologique (date limite) ou par niveau d'importance (priorité).
*   **Persistance locale (JSON) :** Sauvegarde automatique des données dans un fichier local dès qu'une modification est effectuée. Chargement automatique au démarrage.
*   **Architecture robuste :** Gestion centralisée des erreurs via des exceptions personnalisées, utilisation de dépôts génériques et respect des principes de l'encapsulation.

---

## 🛠️ Architecture & Concepts Clés Validés

L'application démontre la maîtrise des concepts suivants :
1.  **Classes abstraites & Héritage :** Classe de base `Task` déclinée en `StandardTask` (priorité variable) et `UrgentTask` (priorité forcée à *High* avec notes d'urgence).
2.  **Interfaces :** Implémentation de l'interface `Serializable` pour structurer la conversion des objets en formats compatibles JSON.
3.  **Génériques :** Définition d'un contrat de stockage réutilisable `Repository<T>` limitant les opérations aux entités de type `Task`.
4.  **Null Safety :** Utilisation rigoureuse des types optionnels (`DateTime?`, `String?`) et opérateurs de coalescence (`??`) pour éviter les plantages.

---

## 📂 Structure du Projet

```text
├── bin/
│   └── main.dart            # Point d'entrée de l'application (Menu CLI)
├── lib/
│   ├── task_model.dart      # Modèles de données, Abstraction et Interfaces
│   └── task_repository.dart # Dépôt générique, gestion JSON et Exceptions
├── test/
│   └── task_test.dart       # Les 5 scénarios de tests unitaires automatisés
├── pubspec.yaml             # Gestionnaire de dépendances du projet
└── taches.json              # Fichier de données généré à l'exécution
```

---

## ⚙️ Prérequis & Installation

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

## 🕹️ Mode d'Emploi de l'Application (CLI)

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

## 🧪 Exécution des Tests Unitaires

La suite de tests vérifie l'intégrité du système de stockage, les restrictions de validation des données, le comportement des états et le cycle de vie de la sérialisation JSON.

Pour lancer les 5 tests automatisés, utilisez la commande standard de l'écosystème Dart :

```bash
dart test
```

### Ce que valident les tests inclus :
1.  **Test 1 :** L'ajout réussi d'une tâche valide étend correctement la taille du tableau en mémoire.
2.  **Test 2 :** L'application lève une exception personnalisée (`TaskException`) si l'utilisateur tente d'enregistrer une tâche sans titre ou composée uniquement d'espaces.
3.  **Test 3 :** La mise à jour du statut passe correctement la propriété booléenne de la tâche à `true`.
4.  **Test 4 :** La suppression d'un ID valide purge la donnée du dépôt.
5.  **Test 5 :** Le mécanisme de persistance encode et décode sans perte les objets complexes (différenciation entre tâche urgente et standard lors de la lecture du fichier JSON).

*Note : Lors du lancement des tests, un fichier temporaire nommé `taches_test.json` est créé, exploité pour les vérifications, puis automatiquement nettoyé afin de ne pas polluer votre espace de travail.*
# gestionnaire_taches_cli
