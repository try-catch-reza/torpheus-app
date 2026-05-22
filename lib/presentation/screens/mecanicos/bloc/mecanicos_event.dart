part of 'mecanicos_bloc.dart';

sealed class MecanicosEvent extends Equatable {
  const MecanicosEvent();

  @override
  List<Object?> get props => [];
}

class MecanicosLoad extends MecanicosEvent {
  const MecanicosLoad();

  @override
  List<Object?> get props => [];
}
