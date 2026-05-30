part of 'funcionario_bloc.dart';

sealed class FuncionarioState extends Equatable {
  const FuncionarioState({this.funcionarios = const []});

  final List<FuncionarioModel> funcionarios;

  @override
  List<Object?> get props => [funcionarios];
}

class FuncionarioInitial extends FuncionarioState {
  const FuncionarioInitial();

  @override
  List<Object?> get props => [];
}

class FuncionarioLoading extends FuncionarioState {
  const FuncionarioLoading();

  @override
  List<Object?> get props => [];
}

class FuncionarioLoaded extends FuncionarioState {
  const FuncionarioLoaded({required super.funcionarios});

  @override
  List<Object?> get props => [funcionarios];
}

class FuncionarioError extends FuncionarioState {
  const FuncionarioError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

final class FuncionarioCadastrando extends FuncionarioState {
  const FuncionarioCadastrando();

  @override
  List<Object?> get props => [];
}
