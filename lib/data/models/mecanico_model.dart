import 'package:equatable/equatable.dart';

class FuncionarioModel extends Equatable {
  const FuncionarioModel({
    this.id,
    this.userId,
    this.nome,
    this.telefone,
    this.documento,
    this.funcao,
    this.isActive,
    this.hiredAt,
  });

  final String? id;
  final String? userId;
  final String? nome;
  final String? telefone;
  final String? documento;
  final String? funcao;
  final bool? isActive;
  final DateTime? hiredAt;

  factory FuncionarioModel.fromJson(Map<String, dynamic> json) {
    return FuncionarioModel(
      id: json['id'] as String?,
      nome: json['name'] as String?,
      telefone: json['phone'] as String?,
      documento: json['document'] as String?,
      funcao: json['function'] as String?,
      isActive: json['isActive'] as bool?,
      hiredAt: json['hiredAt'] != null
          ? DateTime.parse(json['hiredAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': nome,
      'phone': telefone,
      'document': documento,
      'function': funcao,
      'isActive': isActive,
      'hiredAt': hiredAt?.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'MecanicoModel{'
        'id: $id, '
        'userId: $userId,'
        ' nome: $nome, '
        'telefone: $telefone,'
        ' documento: $documento, '
        'funcao: $funcao, '
        'isActive: $isActive, '
        'hiredAt: $hiredAt'
        '}';
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        nome,
        telefone,
        documento,
        funcao,
        isActive,
        hiredAt,
      ];
}
