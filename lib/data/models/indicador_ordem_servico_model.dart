import 'package:equatable/equatable.dart';

import 'indicador_funcionario_tempo.dart';

class IndicadorOrdemServicoModel extends Equatable {
  final DateTime? dataInicio;
  final DateTime? dataFim;
  final int? totalOrdens;
  final int? ordensAbertas;
  final int? ordensAndamento;
  final int? ordensConcluidas;
  final int? ordensCanceladas;
  final int? mediaDuracao;
  final List<IndicadorFuncionarioTempo>? indicadoresFuncionarios;

  const IndicadorOrdemServicoModel({
    this.dataInicio,
    this.dataFim,
    this.totalOrdens,
    this.ordensAbertas,
    this.ordensAndamento,
    this.ordensConcluidas,
    this.ordensCanceladas,
    this.mediaDuracao,
    this.indicadoresFuncionarios,
  });

  factory IndicadorOrdemServicoModel.fromJson(Map<String, dynamic> json) {
    return IndicadorOrdemServicoModel(
      dataInicio: json['startDate'] != null
          ? DateTime.parse(json['startDate'])
          : null,
      dataFim: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
      totalOrdens: json['totalOrders'],
      ordensAbertas: json['openOrders'],
      ordensAndamento: json['inProgressOrders'],
      ordensConcluidas: json['completedOrders'],
      ordensCanceladas: json['canceledOrders'],
      mediaDuracao: json['averageWorkedMinutesPerOrder'],
      indicadoresFuncionarios: json['mechanicsWorkTime'] != null
          ? (json['mechanicsWorkTime'] as List)
              .map((e) => IndicadorFuncionarioTempo.fromJson(e))
              .toList()
          : null,
    );
  }

  @override
  String toString() {
    return 'IndicadorOrdemServicoModel(dataInicio: $dataInicio, dataFim: $dataFim, totalOrdens: $totalOrdens, ordensAbertas: $ordensAbertas, ordensAndamento: $ordensAndamento, ordensConcluidas: $ordensConcluidas, ordensCanceladas: $ordensCanceladas, mediaDuracao: $mediaDuracao)';
  }

  @override
  List<Object?> get props => [
        dataInicio,
        dataFim,
        totalOrdens,
        ordensAbertas,
        ordensAndamento,
        ordensConcluidas,
        ordensCanceladas,
        mediaDuracao,
      ];
}
