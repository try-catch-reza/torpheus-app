part of 'mecanicos_bloc.dart';

sealed class MecanicosState extends Equatable {
  const MecanicosState({this.mecanicos = const []});

  final List<MecanicoModel> mecanicos;

  @override
  List<Object?> get props => [mecanicos];
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
  const MecanicosLoaded({required super.mecanicos});

  @override
  List<Object?> get props => [mecanicos];
}

class MecanicosError extends MecanicosState {
  const MecanicosError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
