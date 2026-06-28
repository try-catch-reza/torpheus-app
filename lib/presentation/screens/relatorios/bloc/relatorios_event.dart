part of 'relatorios_bloc.dart';

sealed class RelatoriosEvent extends Equatable {
  const RelatoriosEvent();

  @override
  List<Object?> get props => [];
}

final class RelatoriosLoad extends RelatoriosEvent {
  const RelatoriosLoad();

  @override
  List<Object?> get props => [];
}

final class RelatoriosSetDataInicio extends RelatoriosEvent {
  final DateTime? dataInicio;

  const RelatoriosSetDataInicio({required this.dataInicio});

  @override
  List<Object?> get props => [dataInicio];
}

final class RelatoriosSetDataFim extends RelatoriosEvent {
  final DateTime? dataFim;

  const RelatoriosSetDataFim({required this.dataFim});

  @override
  List<Object?> get props => [dataFim];
}

final class RelatoriosAplicar extends RelatoriosEvent {
  const RelatoriosAplicar();

  @override
  List<Object?> get props => [];
}

final class RelatoriosSetGranularidade extends RelatoriosEvent {
  final Granularidade granularidade;

  const RelatoriosSetGranularidade({required this.granularidade});

  @override
  List<Object?> get props => [granularidade];
}
