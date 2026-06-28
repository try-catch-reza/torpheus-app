import 'package:equatable/equatable.dart';

class IndicadorFuncionarioTempo extends Equatable {
  final String? funcionarioId;
  final String? funcionarioNome;
  final int? totalHorasTrabalhadas;
  final int? totalOrdens;
  final int? mediaDuracaoOrdens;

  const IndicadorFuncionarioTempo({
    this.funcionarioId,
    this.funcionarioNome,
    this.totalHorasTrabalhadas,
    this.totalOrdens,
    this.mediaDuracaoOrdens,
  });

  factory IndicadorFuncionarioTempo.fromJson(Map<String, dynamic> json) {
    return IndicadorFuncionarioTempo(
      funcionarioId: json['mechanicId'],
      funcionarioNome: json['mechanicName'],
      totalHorasTrabalhadas: json['totalWorkedMinutes'],
      totalOrdens: json['ordersCount'],
      mediaDuracaoOrdens: json['averageMinutesPerOrder'],
    );
  }

  @override
  String toString() {
    return 'IndicadorFuncionarioTempo(funcionarioId: $funcionarioId, funcionarioNome: $funcionarioNome, totalHorasTrabalhadas: $totalHorasTrabalhadas, totalOrdens: $totalOrdens, mediaDuracaoOrdens: $mediaDuracaoOrdens)';
  }

  @override
  List<Object?> get props => [
        funcionarioId,
        funcionarioNome,
        totalHorasTrabalhadas,
        totalOrdens,
        mediaDuracaoOrdens,
      ];
}
