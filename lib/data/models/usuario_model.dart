import 'package:equatable/equatable.dart';

class UsuarioModel extends Equatable {
  const UsuarioModel({
    this.id,
    this.nome,
    this.email,
    this.telefone,
    this.documento,
    this.cargo,
    this.isActive,
    this.createdAt,
  });

  final String? id;
  final String? nome;
  final String? email;
  final String? telefone;
  final String? documento;
  final String? cargo;
  final bool? isActive;
  final DateTime? createdAt;

  factory UsuarioModel.fromJson(Map<String, dynamic> json) {
    return UsuarioModel(
      id: json['id'] as String?,
      nome: json['name'] as String?,
      email: json['email'] as String?,
      telefone: json['phone'] as String?,
      documento: json['document'] as String?,
      cargo: json['role'] as String?,
      isActive: json['isActive'] as bool?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': nome,
      'email': email,
      'phone': telefone,
      'document': documento,
      'role': cargo,
      'isActive': isActive,
      'createdAt': createdAt?.toIso8601String(),
    };
  }

  UsuarioModel copyWith({
    String? id,
    String? nome,
    String? email,
    String? telefone,
    String? documento,
    String? cargo,
    bool? isActive,
    DateTime? createdAt,
  }) {
    return UsuarioModel(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      email: email ?? this.email,
      telefone: telefone ?? this.telefone,
      documento: documento ?? this.documento,
      cargo: cargo ?? this.cargo,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() {
    return 'UsuarioModel{'
        'id: $id, '
        'nome: $nome, '
        'email: $email, '
        'telefone: $telefone, '
        'documento: $documento, '
        'cargo: $cargo, '
        'isActive: $isActive, '
        'createdAt: $createdAt'
        '}';
  }

  @override
  List<Object?> get props => [
        id,
        nome,
        email,
        telefone,
        documento,
        cargo,
        isActive,
        createdAt,
      ];
}

