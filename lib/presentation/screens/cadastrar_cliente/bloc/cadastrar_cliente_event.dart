part of 'cadastrar_cliente_bloc.dart';

sealed class CadastrarClienteEvent extends Equatable {
  const CadastrarClienteEvent();

  @override
  List<Object?> get props => [];
}

final class CadastrarClienteLoad extends CadastrarClienteEvent {
  const CadastrarClienteLoad();

  @override
  List<Object?> get props => [];
}

final class CadastrarClienteSubmit extends CadastrarClienteEvent {
  const CadastrarClienteSubmit({
    required this.nome,
    required this.email,
    required this.cpf,
    required this.telefone,
  });

  final String nome;
  final String email;
  final String cpf;
  final String telefone;

  @override
  List<Object?> get props => [nome, email, cpf, telefone];
}
