part of 'cadastrar_funcionario_bloc.dart';

sealed class CadastrarFuncionarioState extends Equatable {
  const CadastrarFuncionarioState();

  @override
  List<Object?> get props => [];
}

final class CadastrarFuncionarioInitial extends CadastrarFuncionarioState {
  const CadastrarFuncionarioInitial();
}

final class CadastrarFuncionarioLoading extends CadastrarFuncionarioState {
  const CadastrarFuncionarioLoading();
}

final class CadastrarFuncionarioLoaded extends CadastrarFuncionarioState {
  const CadastrarFuncionarioLoaded();
}

final class CadastrarFuncionarioSuccess extends CadastrarFuncionarioState {
  const CadastrarFuncionarioSuccess();
}

final class CadastrarFuncionarioError extends CadastrarFuncionarioState {
  const CadastrarFuncionarioError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
