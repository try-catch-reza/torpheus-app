import 'package:equatable/equatable.dart';

class MecanicoModel extends Equatable {
  const MecanicoModel({
    this.id,
    this.nome,
    this.telefone,
    this.email,
    this.isActive,
    this.createdAt,
  });

  final String? id;
  final String? nome;
  final String? telefone;
  final String? email;
  final bool? isActive;
  final DateTime? createdAt;

  String get iniciais {
    if (nome == null || nome!.trim().isEmpty) return '';
    final partes = nome!.trim().split(' ');
    if (partes.length >= 2) {
      return '${partes.first[0]}${partes.last[0]}'.toUpperCase();
    }
    return partes.first.substring(0, partes.first.length >= 2 ? 2 : partes.first.length).toUpperCase();
  }

  factory MecanicoModel.fromJson(Map<String, dynamic> json) {
    return MecanicoModel(
      id: json['id'] as String?,
      nome: json['name'] as String?,
      telefone: json['phone'] as String?,
      email: json['email'] as String?,
      isActive: json['isActive'] as bool?,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt'] as String) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': nome,
      'phone': telefone,
      'email': email,
    };
  }

  @override
  List<Object?> get props => [id, nome, telefone, email, isActive, createdAt];
}
