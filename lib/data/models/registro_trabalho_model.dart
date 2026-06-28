import 'package:equatable/equatable.dart';

class RegistroTrabalhoModel extends Equatable {
  final String? id;
  final String? mechanicId;
  final int? durationMinutes;
  final DateTime? performedAt;
  final String? note;
  final DateTime? createdAt;

  const RegistroTrabalhoModel({
    this.id,
    this.mechanicId,
    this.durationMinutes,
    this.performedAt,
    this.note,
    this.createdAt,
  });

  factory RegistroTrabalhoModel.fromMap(Map<String, dynamic> map) {
    return RegistroTrabalhoModel(
      id: map['id'],
      mechanicId: map['mechanicId'],
      durationMinutes: map['durationMinutes'],
      performedAt: map['performedAt'] != null
          ? DateTime.parse(map['performedAt'] as String)
          : null,
      note: map['note'],
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'mechanicId': mechanicId,
      'durationMinutes': durationMinutes,
      'performedAt': performedAt?.toIso8601String(),
      'note': note,
      'createdAt': createdAt?.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'RegistroTrabalhoModel{'
        'id: $id, '
        'mechanicId: $mechanicId, '
        'durationMinutes: $durationMinutes, '
        'performedAt: $performedAt, '
        'note: $note, '
        'createdAt: $createdAt'
        '}';
  }

  @override
  List<Object?> get props => [
        id,
        mechanicId,
        durationMinutes,
        performedAt,
        note,
        createdAt,
      ];
}