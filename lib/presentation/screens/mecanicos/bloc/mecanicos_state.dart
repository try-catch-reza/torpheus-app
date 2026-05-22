part of 'mecanicos_bloc.dart';

sealed class MecanicosState extends Equatable {
  const MecanicosState();

  @override
  List<Object?> get props => [];
}

class MecanicosInitial extends MecanicosState {
  const MecanicosInitial();

  @override
  List<Object?> get props => [];
}

class MecanicosLoading extends MecanicosState {
  const MecanicosLoading();

  @override
  List<Object?> get props => [];
}

class MecanicosLoaded extends MecanicosState {
  const MecanicosLoaded();

  @override
  List<Object?> get props => [];
}
