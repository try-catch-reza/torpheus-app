import 'package:equatable/equatable.dart';

class UsuarioModel extends Equatable {
  const UsuarioModel({
    this.id,
    this.nome,
    this.senha,
    this.email,
    this.roleId,
    this.isActive,
    this.createdAt,
  });

  final String? id;
  final String? nome;
  final String? senha;
  final String? email;
  final String? roleId;
  final bool? isActive;
  final DateTime? createdAt;

  factory UsuarioModel.fromJson(Map<String, dynamic> json) {
    return UsuarioModel(
      id: json['id'] as String?,
      nome: json['name'] as String?,
      email: json['email'] as String?,
      roleId: json['roleId'] as String?,
      isActive: json['isActive'] as bool?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toAPI() {
    return {
      'name': nome,
      'email': email,
      'password': senha,
      'roleId': roleId,
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
        'isActive: $isActive, '
        'createdAt: $createdAt, '
        'roleId: $roleId, '
        'senha: $senha, '
        '}';
  }

  @override
  List<Object?> get props => [
        id,
        nome,
        email,
        isActive,
        createdAt,
      ];
}
