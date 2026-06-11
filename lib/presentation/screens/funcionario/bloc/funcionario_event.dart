part of 'funcionario_bloc.dart';

sealed class FuncionarioEvent extends Equatable {
  const FuncionarioEvent();

  @override
  List<Object?> get props => [];
}

class FuncionarioLoad extends FuncionarioEvent {
  const FuncionarioLoad();

  @override
  List<Object?> get props => [];
}

final class FuncionarioSearch extends FuncionarioEvent {
  const FuncionarioSearch(this.search);

  final String search;

  @override
  List<Object?> get props => [search];
}

final class FuncionarioSetFuncao extends FuncionarioEvent {
  const FuncionarioSetFuncao(this.funcao);

  final Funcao funcao;

  @override
  List<Object?> get props => [funcao];
}

final class FuncionarioSetUsuario extends FuncionarioEvent {
  const FuncionarioSetUsuario(this.usuario);

  final UsuarioModel usuario;

  @override
  List<Object?> get props => [usuario];
}

final class FuncionarioSubmit extends FuncionarioEvent {
  const FuncionarioSubmit({
    required this.nome,
    required this.telefone,
    required this.documento,
  });

  final String nome;
  final String telefone;
  final String documento;

  @override
  List<Object?> get props => [nome, telefone, documento];
}

final class FuncionarioUpdate extends FuncionarioEvent {
  const FuncionarioUpdate({
    required this.nome,
    required this.telefone,
    required this.documento,
  });

  final String nome;
  final String telefone;
  final String documento;

  @override
  List<Object?> get props => [nome, telefone, documento];
}
