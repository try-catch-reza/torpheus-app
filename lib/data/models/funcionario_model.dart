import 'package:equatable/equatable.dart';

import '../../core/constants/enum/documento_tipo.dart';

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
    this.documentType,
  });

  final String? id;
  final String? userId;
  final String? nome;
  final String? telefone;
  final String? documento;
  final String? funcao;
  final bool? isActive;
  final DateTime? hiredAt;
  final DocumentoTipo? documentType;

  factory FuncionarioModel.fromJson(Map<String, dynamic> json) {
    return FuncionarioModel(
      id: json['id'] as String?,
      userId: json['userId'] as String?,
      nome: json['name'] as String?,
      telefone: json['phone'] as String?,
      funcao: json['function'] as String?,
      isActive: json['isActive'] as bool?,
      hiredAt: json['hiredAt'] != null
          ? DateTime.parse(json['hiredAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': nome,
      'function': funcao,
      'phone': telefone,
      'documentNumber': documento,
      'documentType': documentType?.value,
    };
  }

  @override
  String toString() {
    return 'MecanicoModel{'
        'id: $id, '
        'userId: $userId, '
        'nome: $nome, '
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
