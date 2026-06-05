part of 'cadastrar_funcionario_bloc.dart';

sealed class CadastrarFuncionarioState extends Equatable {
  const CadastrarFuncionarioState({
    this.usuarios = const [],
    this.usuarioSelecionado,
    this.funcaoSelecionada,
  });

  final List<UsuarioModel> usuarios;
  final UsuarioModel? usuarioSelecionado;
  final Funcao? funcaoSelecionada;

  @override
  List<Object?> get props => [];
}

final class CadastrarFuncionarioInitial extends CadastrarFuncionarioState {
  const CadastrarFuncionarioInitial();
}

final class CadastrarFuncionarioLoading extends CadastrarFuncionarioState {
  const CadastrarFuncionarioLoading({
    super.funcaoSelecionada,
    super.usuarioSelecionado,
  });

  @override
  List<Object?> get props => [funcaoSelecionada, usuarioSelecionado];
}

final class CadastrarFuncionarioLoaded extends CadastrarFuncionarioState {
  const CadastrarFuncionarioLoaded({
    super.usuarios,
    super.usuarioSelecionado,
    super.funcaoSelecionada,
  });

  @override
  List<Object?> get props => [usuarios, funcaoSelecionada, usuarioSelecionado];
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
