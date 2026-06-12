part of 'cadastrar_funcionario_bloc.dart';

sealed class CadastrarFuncionarioState extends Equatable {
  const CadastrarFuncionarioState({
    this.usuarios = const [],
    this.usuarioSelecionado,
    this.funcaoSelecionada,
    this.funcionario,
  });

  final List<UsuarioModel> usuarios;
  final UsuarioModel? usuarioSelecionado;
  final Funcao? funcaoSelecionada;
  final FuncionarioModel? funcionario;

  @override
  List<Object?> get props => [funcionario];
}

final class CadastrarFuncionarioInitial extends CadastrarFuncionarioState {
  const CadastrarFuncionarioInitial();
}

final class CadastrarFuncionarioLoading extends CadastrarFuncionarioState {
  const CadastrarFuncionarioLoading({
    super.funcaoSelecionada,
    super.usuarioSelecionado,
    super.funcionario,
  });

  @override
  List<Object?> get props => [
        funcaoSelecionada,
        usuarioSelecionado,
        funcionario,
      ];
}

final class CadastrarFuncionarioLoaded extends CadastrarFuncionarioState {
  const CadastrarFuncionarioLoaded({
    super.usuarios,
    super.usuarioSelecionado,
    super.funcaoSelecionada,
    super.funcionario,
  });

  @override
  List<Object?> get props => [
        usuarios,
        funcaoSelecionada,
        usuarioSelecionado,
        funcionario,
      ];
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

final class CadastrarFuncionarioAtualizado extends CadastrarFuncionarioState {
  const CadastrarFuncionarioAtualizado({required super.funcionario});

  @override
  List<Object?> get props => [funcionario];
}
