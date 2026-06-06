part of 'funcionario_bloc.dart';

sealed class FuncionarioState extends Equatable {
  const FuncionarioState({
    this.funcionarios = const [],
    this.funcionariosFiltered = const [],
    this.hasCriarFuncionario = false,
    this.search = '',
  });

  final List<FuncionarioModel> funcionarios;
  final List<FuncionarioModel> funcionariosFiltered;

  final bool hasCriarFuncionario;
  final String search;

  @override
  List<Object?> get props => [
        funcionarios,
        hasCriarFuncionario,
        search,
      ];
}

class FuncionarioInitial extends FuncionarioState {
  const FuncionarioInitial();

  @override
  List<Object?> get props => [];
}

class FuncionarioLoading extends FuncionarioState {
  const FuncionarioLoading({
    super.funcionarios,
    super.funcionariosFiltered,
  });

  @override
  List<Object?> get props => [funcionarios, funcionariosFiltered];
}

class FuncionarioLoaded extends FuncionarioState {
  const FuncionarioLoaded({
    required super.funcionarios,
    required super.funcionariosFiltered,
    super.hasCriarFuncionario,
    super.search,
  });

  @override
  List<Object?> get props => [
        funcionarios,
        funcionariosFiltered,
        hasCriarFuncionario,
        search,
      ];
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
