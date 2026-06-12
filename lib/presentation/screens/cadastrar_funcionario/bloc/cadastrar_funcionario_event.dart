part of 'cadastrar_funcionario_bloc.dart';

sealed class CadastrarFuncionarioEvent extends Equatable {
  const CadastrarFuncionarioEvent();

  @override
  List<Object?> get props => [];
}

final class CadastrarFuncionarioLoad extends CadastrarFuncionarioEvent {
  const CadastrarFuncionarioLoad({this.id});

  final String? id;

  @override
  List<Object?> get props => [id];
}

final class CadastrarFuncionarioSubmit extends CadastrarFuncionarioEvent {
  const CadastrarFuncionarioSubmit({
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

final class CadastrarFuncionarioSetFuncao extends CadastrarFuncionarioEvent {
  const CadastrarFuncionarioSetFuncao(this.funcao);

  final Funcao funcao;

  @override
  List<Object?> get props => [funcao];
}

final class CadastrarFuncionarioSetUsuario extends CadastrarFuncionarioEvent {
  const CadastrarFuncionarioSetUsuario(this.usuario);

  final UsuarioModel usuario;

  @override
  List<Object?> get props => [usuario];
}

final class CadastrarFuncionarioUpdate extends CadastrarFuncionarioEvent {
  const CadastrarFuncionarioUpdate({
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

final class CadastrarFuncionarioSetAtivo extends CadastrarFuncionarioEvent {

}
