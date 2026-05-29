part of 'mecanicos_bloc.dart';

sealed class MecanicosState extends Equatable {
  const MecanicosState({this.funcionarios = const []});

  final List<FuncionarioModel> funcionarios;

  @override
  List<Object?> get props => [funcionarios];
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
  const MecanicosLoaded({required super.funcionarios});

  @override
  List<Object?> get props => [funcionarios];
}

class MecanicosError extends MecanicosState {
  const MecanicosError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

final class MecanicoCadastrando extends MecanicosState {
  const MecanicoCadastrando();

  @override
  List<Object?> get props => [];
}
