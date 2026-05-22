part of 'ordens_servico_bloc.dart';

sealed class OrdensServicoEvent extends Equatable {
  const OrdensServicoEvent();

  @override
  List<Object?> get props => [];
}

final class OrdensServicoLoad extends OrdensServicoEvent {
  const OrdensServicoLoad();

  @override
  List<Object?> get props => [];
}
