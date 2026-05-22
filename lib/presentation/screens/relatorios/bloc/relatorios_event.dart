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
