enum Priorite { low, medium, high }

// Interface obligatoire
abstract class Serializable {
  Map<String, dynamic> toJson();
}

// Classe abstraite de base
abstract class Task implements Serializable {
  String id;
  String titre;
  Priorite priorite;
  DateTime? dateLimite;
  bool estTerminee;

  Task({
    required this.id,
    required this.titre,
    required this.priorite,
    this.dateLimite,
    this.estTerminee = false,
  });

  String get type;
}

// Héritage 1 : Tâche standard
class StandardTask extends Task {
  StandardTask({
    required super.id,
    required super.titre,
    required super.priorite,
    super.dateLimite,
    super.estTerminee,
  });

  @override
  String get type => 'Standard';

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'titre': titre,
        'priorite': priorite.name,
        'dateLimite': dateLimite?.toIso8601String(),
        'estTerminee': estTerminee,
        'type': type,
      };

  factory StandardTask.fromJson(Map<String, dynamic> json) => StandardTask(
        id: json['id'],
        titre: json['titre'],
        priorite: Priorite.values.byName(json['priorite']),
        dateLimite: json['dateLimite'] != null ? DateTime.parse(json['dateLimite']) : null,
        estTerminee: json['estTerminee'] ?? false,
      );
}

// Héritage 2 : Tâche Urgente
class UrgentTask extends Task {
  String notesUrgence;

  UrgentTask({
    required super.id,
    required super.titre,
    super.dateLimite,
    super.estTerminee,
    this.notesUrgence = "À traiter immédiatement !",
  }) : super(priorite: Priorite.high);

  @override
  String get type => 'Urgent';

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'titre': titre,
        'priorite': priorite.name,
        'dateLimite': dateLimite?.toIso8601String(),
        'estTerminee': estTerminee,
        'type': type,
        'notesUrgence': notesUrgence,
      };

  factory UrgentTask.fromJson(Map<String, dynamic> json) => UrgentTask(
        id: json['id'],
        titre: json['titre'],
        dateLimite: json['dateLimite'] != null ? DateTime.parse(json['dateLimite']) : null,
        estTerminee: json['estTerminee'] ?? false,
        notesUrgence: json['notesUrgence'] ?? "À traiter immédiatement !",
      );
}
