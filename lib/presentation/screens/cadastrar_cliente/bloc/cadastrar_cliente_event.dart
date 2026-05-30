part of 'cadastrar_cliente_bloc.dart';

sealed class CadastrarClienteEvent extends Equatable {
  const CadastrarClienteEvent();

  @override
  List<Object?> get props => [];
}

final class CadastrarClienteLoad extends CadastrarClienteEvent {
  const CadastrarClienteLoad({required this.isEdit, required this.clienteId});

  final bool isEdit;
  final String clienteId;

  @override
  List<Object?> get props => [isEdit, clienteId];
}

final class CadastrarClienteSubmit extends CadastrarClienteEvent {
  const CadastrarClienteSubmit({required this.cliente});

  final ClienteModel cliente;

  @override
  List<Object?> get props => [cliente];
}

final class CadastrarClienteSetCEP extends CadastrarClienteEvent {
  const CadastrarClienteSetCEP(this.cep);

  final String cep;

  @override
  List<Object?> get props => [cep];
}

final class CadastrarClienteSelecionarDocumento extends CadastrarClienteEvent {
  const CadastrarClienteSelecionarDocumento(this.documentoTipo);

  final DocumentoTipo documentoTipo;

  @override
  List<Object?> get props => [documentoTipo];
}

final class CadastrarClienteUpdate extends CadastrarClienteEvent {
  const CadastrarClienteUpdate({required this.cliente});

  final ClienteModel cliente;

  @override
  List<Object?> get props => [cliente];
}

final class CadastrarClienteSetAtivo extends CadastrarClienteEvent {
  const CadastrarClienteSetAtivo(this.isActive);

  final bool isActive;

  @override
  List<Object?> get props => [isActive];
}
