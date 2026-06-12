part of 'funcionario_bloc.dart';

sealed class FuncionarioState extends Equatable {
  const FuncionarioState({
    this.funcionarios = const [],
    this.funcionariosFiltered = const [],
    this.hasCriarFuncionario = false,
    this.search = '',
    this.usuarios = const [],
    this.usuarioSelecionado,
    this.funcaoSelecionada,
    this.hasEditarFuncionario = false,
    this.funcionarioEditar,
  });

  final List<FuncionarioModel> funcionarios;
  final List<FuncionarioModel> funcionariosFiltered;
  final List<UsuarioModel> usuarios;
  final UsuarioModel? usuarioSelecionado;
  final Funcao? funcaoSelecionada;
  final FuncionarioModel? funcionarioEditar;

  final bool hasCriarFuncionario;
  final bool hasEditarFuncionario;

  final String search;

  @override
  List<Object?> get props => [
        funcionarios,
        hasCriarFuncionario,
        search,
        usuarios,
        usuarioSelecionado,
        funcaoSelecionada,
        hasEditarFuncionario,
        funcionarioEditar,
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
    super.usuarios,
    super.funcaoSelecionada,
    super.usuarioSelecionado,
    super.hasCriarFuncionario,
    super.hasEditarFuncionario,
  });

  @override
  List<Object?> get props => [
        funcionarios,
        funcionariosFiltered,
        usuarios,
        usuarioSelecionado,
        hasCriarFuncionario,
        funcaoSelecionada,
        hasEditarFuncionario,
      ];
}

class FuncionarioLoaded extends FuncionarioState {
  const FuncionarioLoaded({
    required super.funcionarios,
    required super.funcionariosFiltered,
    super.hasCriarFuncionario,
    super.search,
    super.usuarios,
    super.funcaoSelecionada,
    super.usuarioSelecionado,
    super.hasEditarFuncionario,
    super.funcionarioEditar,
  });

  @override
  List<Object?> get props => [
        funcionarios,
        funcionariosFiltered,
        hasCriarFuncionario,
        search,
        usuarios,
        usuarioSelecionado,
        funcaoSelecionada,
        hasEditarFuncionario,
        funcionarioEditar,
      ];
}

class FuncionarioError extends FuncionarioState {
  const FuncionarioError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

final class FuncionarioSalvando extends FuncionarioState {
  const FuncionarioSalvando();

  @override
  List<Object?> get props => [];
}

final class FuncionarioSalvo extends FuncionarioState {
  const FuncionarioSalvo();

  @override
  List<Object?> get props => [];
}

final class FuncionarioAtualizando extends FuncionarioState {
  const FuncionarioAtualizando({
    super.funcionarios,
    super.funcionariosFiltered,
    super.usuarios,
    super.funcaoSelecionada,
    super.usuarioSelecionado,
    super.hasCriarFuncionario,
    super.hasEditarFuncionario,
    super.funcionarioEditar,
  });

  @override
  List<Object?> get props => [
        funcionarios,
        funcionariosFiltered,
        usuarios,
        usuarioSelecionado,
        hasCriarFuncionario,
        funcaoSelecionada,
        hasEditarFuncionario,
        funcionarioEditar,
      ];
}

final class FuncionarioAtualizado extends FuncionarioState {
  const FuncionarioAtualizado();

  @override
  List<Object?> get props => [];
}

class FuncionarioErrorInicial extends FuncionarioState {
  const FuncionarioErrorInicial(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
