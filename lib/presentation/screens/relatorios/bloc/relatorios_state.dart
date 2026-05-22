part of 'relatorios_bloc.dart';

sealed class RelatoriosState extends Equatable {
  const RelatoriosState();

  @override
  List<Object?> get props => [];
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
  const RelatoriosLoaded();

  @override
  List<Object?> get props => [];
}

final class RelatoriosError extends RelatoriosState {
  final String message;
  const RelatoriosError({required this.message});

  @override
  List<Object?> get props => [message];
}
