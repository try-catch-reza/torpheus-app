part of 'cadastrar_funcionario_bloc.dart';

sealed class CadastrarFuncionarioEvent extends Equatable {
  const CadastrarFuncionarioEvent();

  @override
  List<Object?> get props => [];
}

final class CadastrarFuncionarioLoad extends CadastrarFuncionarioEvent {
  const CadastrarFuncionarioLoad();

  @override
  List<Object?> get props => [];
}

final class CadastrarFuncionarioSubmit extends CadastrarFuncionarioEvent {
  const CadastrarFuncionarioSubmit({required this.funcionario});

  final FuncionarioModel funcionario;

  @override
  List<Object?> get props => [funcionario];
}


