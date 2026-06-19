import 'package:equatable/equatable.dart';
import 'package:torpheus/core/constants/enum/status_servico.dart';

class ServicoModel extends Equatable {
  final String? id;
  final String? descricao;
  final StatusServico? statusServico;
  final String? funcionarioId;
  final DateTime? dataCriacao;

  const ServicoModel({
    this.id,
    this.descricao,
    this.statusServico,
    this.funcionarioId,
    this.dataCriacao,
  });

  ServicoModel copyWith({
    String? id,
    String? descricao,
    StatusServico? statusServico,
    String? funcionarioId,
    DateTime? dataCriacao,
  }) {
    return ServicoModel(
      id: id ?? this.id,
      descricao: descricao ?? this.descricao,
      statusServico: statusServico ?? this.statusServico,
      funcionarioId: funcionarioId ?? this.funcionarioId,
      dataCriacao: dataCriacao ?? this.dataCriacao,
    );
  }

  factory ServicoModel.fromJson(Map<String, dynamic> json) {
    return ServicoModel(
      id: json['id'],
      descricao: json['description'],
      statusServico: StatusServico.fromValues(json['status']),
      funcionarioId: json['mechanicId'],
      dataCriacao: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': descricao,
      'status': statusServico?.value,
      'mechanicId': funcionarioId,
      'createdAt': dataCriacao?.toIso8601String(),
    };
  }

  Map<String, dynamic> toPatchStatus() {
    return {
      'status': statusServico?.value,
    };
  }

  Map<String, dynamic> toPUTDescrAndFunc() {
    return {
      'description': descricao,
      'mechanicId': funcionarioId,
    };
  }

  @override
  List<Object?> get props => [
        id,
        descricao,
        statusServico,
        funcionarioId,
        dataCriacao,
      ];
}
