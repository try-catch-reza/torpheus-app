import 'package:equatable/equatable.dart';
import 'package:torpheus/core/constants/enum/status_servico.dart';
import 'package:torpheus/data/models/registro_trabalho_model.dart';

import 'foto_model.dart';

class ServicoModel extends Equatable {
  final String? id;
  final String? descricao;
  final StatusServico? statusServico;
  final String? funcionarioId;
  final String? funcionarioNome;
  final DateTime? dataCriacao;
  final List<FotoModel>? fotos;
  final List<RegistroTrabalhoModel>? registroTrabalho;

  const ServicoModel({
    this.id,
    this.descricao,
    this.statusServico,
    this.funcionarioNome,
    this.funcionarioId,
    this.dataCriacao,
    this.fotos,
    this.registroTrabalho,
  });

  ServicoModel copyWith({
    String? id,
    String? descricao,
    StatusServico? statusServico,
    String? funcionarioId,
    DateTime? dataCriacao,
    String? funcionarioNome,
  }) {
    return ServicoModel(
      id: id ?? this.id,
      descricao: descricao ?? this.descricao,
      statusServico: statusServico ?? this.statusServico,
      funcionarioId: funcionarioId ?? this.funcionarioId,
      dataCriacao: dataCriacao ?? this.dataCriacao,
      funcionarioNome: funcionarioNome ?? this.funcionarioNome,
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
      funcionarioNome: json['mechanicName'],
      fotos: json['photos'] != null
          ? (json['photos'] as List)
              .map((photo) => FotoModel.fromMap(photo))
              .toList()
          : null,
      registroTrabalho: json['workLogs'] != null
          ? (json['workLogs'] as List)
              .map((record) => RegistroTrabalhoModel.fromMap(record))
              .toList()
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
      'mechanicName': funcionarioNome,
      'photos': fotos?.map((photo) => photo.toMap()).toList(),
      'workLogs': registroTrabalho?.map((record) => record.toMap()).toList(),
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
        funcionarioNome,
        fotos,
        registroTrabalho,
      ];
}
