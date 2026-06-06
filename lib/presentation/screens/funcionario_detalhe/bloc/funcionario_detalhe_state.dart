part of 'funcionario_detalhe_bloc.dart';

sealed class FuncionarioDetalheState extends Equatable {
  const FuncionarioDetalheState({
    this.funcionario,
    this.hasEditarFuncionario = false,
  });

  final FuncionarioModel? funcionario;
  final bool hasEditarFuncionario;

  @override
  List<Object?> get props => [funcionario, hasEditarFuncionario];
}

final class FuncionarioDetalheInitial extends FuncionarioDetalheState {
  const FuncionarioDetalheInitial();
}

final class FuncionarioDetalheLoading extends FuncionarioDetalheState {
  const FuncionarioDetalheLoading();
}

final class FuncionarioDetalheLoaded extends FuncionarioDetalheState {
  const FuncionarioDetalheLoaded({
    required super.funcionario,
    required super.hasEditarFuncionario,
  });

  @override
  List<Object?> get props => [funcionario];
}

final class FuncionarioDetalheError extends FuncionarioDetalheState {
  const FuncionarioDetalheError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
