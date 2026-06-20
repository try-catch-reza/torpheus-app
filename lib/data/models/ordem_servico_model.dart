import 'package:equatable/equatable.dart';
import 'package:torpheus/data/models/servico_model.dart';

import '../../core/constants/enum/status_ordem.dart';

class OrdemServicoModel extends Equatable {
  final String? id;
  final String? clienteId;
  final String? clienteNome;
  final String? veiculoId;
  final String? veiculoPlaca;
  final String? veiculoModelo;
  final StatusOrdem? statusOrdem;
  final String? descricaoCliente;
  final DateTime? dataInicio;
  final DateTime? dataFim;
  final DateTime? dataCriacao;
  final List<ServicoModel>? servicos;
  final int? quantidadeServico;

  const OrdemServicoModel({
    this.clienteNome,
    this.veiculoPlaca,
    this.veiculoModelo,
    this.id,
    this.clienteId,
    this.veiculoId,
    this.statusOrdem,
    this.descricaoCliente,
    this.dataInicio,
    this.dataFim,
    this.dataCriacao,
    this.servicos,
    this.quantidadeServico,
  });

  OrdemServicoModel copyWith({
    String? id,
    String? clienteId,
    String? veiculoId,
    StatusOrdem? statusOrdem,
    String? descricaoCliente,
    DateTime? dataInicio,
    DateTime? dataFim,
    DateTime? dataCriacao,
    List<ServicoModel>? servicos,
    int? quantidadeServico,
    String? clienteNome,
    String? veiculoModelo,
    String? veiculoPlaca,
  }) {
    return OrdemServicoModel(
      id: id ?? this.id,
      clienteId: clienteId ?? this.clienteId,
      veiculoId: veiculoId ?? this.veiculoId,
      statusOrdem: statusOrdem ?? this.statusOrdem,
      descricaoCliente: descricaoCliente ?? this.descricaoCliente,
      dataInicio: dataInicio ?? this.dataInicio,
      dataFim: dataFim ?? this.dataFim,
      dataCriacao: dataCriacao ?? this.dataCriacao,
      servicos: servicos ?? this.servicos,
      quantidadeServico: quantidadeServico ?? this.quantidadeServico,
      clienteNome: clienteNome ?? this.clienteNome,
      veiculoModelo: veiculoModelo ?? this.veiculoModelo,
      veiculoPlaca: veiculoPlaca ?? this.veiculoPlaca,
    );
  }

  factory OrdemServicoModel.fromJson(Map<String, dynamic> json) {
    return OrdemServicoModel(
      id: json['id'],
      clienteId: json['clientId'],
      veiculoId: json['vehicleId'],
      statusOrdem: StatusOrdem.fromValues(json['status']),
      descricaoCliente: json['clientDescription'],
      dataInicio: json['startDate'] != null
          ? DateTime.parse(json['startDate'] as String)
          : null,
      dataCriacao: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      dataFim: json['endDate'] != null
          ? DateTime.parse(json['endDate'] as String)
          : null,
      servicos: json['items'] != null
          ? (json['items'] as List)
              .map((item) => ServicoModel.fromJson(item))
              .toList()
          : [],
      quantidadeServico: json['servicesCount'],
      clienteNome: json['clientName'],
      veiculoModelo: json['vehicleModel'],
      veiculoPlaca: json['vehicleLicensePlate'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'clientId': clienteId,
      'vehicleId': veiculoId,
      'status': statusOrdem?.value,
      'description': descricaoCliente,
      'startAt': dataInicio?.toIso8601String(),
      'endAt': dataFim?.toIso8601String(),
      'createdAt': dataCriacao?.toIso8601String(),
      'servicos': servicos?.map((s) => s.toJson()).toList(),
      'clientName': clienteNome,
      'vehicleModel': veiculoModelo,
      'vehicleLicensePlate': veiculoPlaca,
    };
  }

  Map<String, dynamic> toPOST() {
    return {
      'clientId': clienteId,
      'vehicleId': veiculoId,
      'clientDescription': descricaoCliente,
      'items': servicos,
    };
  }

  @override
  String toString() {
    return '{'
        'id: $id, '
        'clienteId: $clienteId, '
        'veiculoId: $veiculoId, '
        'statusOrdem: ${statusOrdem?.value}, '
        'descricaoCliente: $descricaoCliente, '
        'dataInicio: $dataInicio, '
        'dataFim: $dataFim, '
        'dataCriacao: $dataCriacao, '
        'servicos: $servicos, '
        'clienteNome: $clienteNome, '
        'veiculoModelo: $veiculoModelo, '
        'veiculoPlaca: $veiculoPlaca, '
        '}';
  }

  @override
  List<Object?> get props => [
        id,
        clienteId,
        veiculoId,
        statusOrdem,
        descricaoCliente,
        dataInicio,
        dataFim,
        dataCriacao,
        servicos,
        veiculoModelo,
        veiculoPlaca,
        clienteNome,
      ];
}
