part of 'ordens_servico_bloc.dart';

sealed class OrdensServicoState extends Equatable {
  const OrdensServicoState();

  @override
  List<Object?> get props => [];
}

final class OrdensServicoInitial extends OrdensServicoState {
  const OrdensServicoInitial();

  @override
  List<Object?> get props => [];
}

final class OrdensServicoLoading extends OrdensServicoState {
  const OrdensServicoLoading();

  @override
  List<Object?> get props => [];
}

final class OrdensServicoLoaded extends OrdensServicoState {
  const OrdensServicoLoaded();

  @override
  List<Object?> get props => [];
}

final class OrdensServicoError extends OrdensServicoState {
  final String message;
  const OrdensServicoError({required this.message});

  @override
  List<Object?> get props => [message];
}
