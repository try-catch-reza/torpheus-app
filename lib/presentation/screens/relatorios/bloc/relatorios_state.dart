part of 'relatorios_bloc.dart';

sealed class RelatoriosState extends Equatable {
  const RelatoriosState({
    this.indicador,
    this.indicadorPeriodo,
    this.dataInicio,
    this.dataFim,
    this.granularidade,
  });

  final IndicadorOrdemServicoModel? indicador;
  final IndicadorOrdemServicoPeriodoModel? indicadorPeriodo;
  final DateTime? dataInicio;
  final DateTime? dataFim;
  final Granularidade? granularidade;

  @override
  List<Object?> get props => [
        indicador,
        dataInicio,
        dataFim,
        indicadorPeriodo,
        granularidade,
      ];
}

final class RelatoriosInitial extends RelatoriosState {
  const RelatoriosInitial();

  @override
  List<Object?> get props => [];
}

final class RelatoriosLoading extends RelatoriosState {
  const RelatoriosLoading();

  @override
  List<Object?> get props => [];
}

final class RelatoriosLoaded extends RelatoriosState {
  const RelatoriosLoaded({
    required super.indicador,
    required super.indicadorPeriodo,
    super.dataInicio,
    super.dataFim,
    super.granularidade,
  });

  @override
  List<Object?> get props => [
        indicador,
        dataInicio,
        dataFim,
        indicadorPeriodo,
        granularidade,
      ];
}

final class RelatoriosError extends RelatoriosState {
  final String message;

  const RelatoriosError({required this.message});

  @override
  List<Object?> get props => [message];
}
