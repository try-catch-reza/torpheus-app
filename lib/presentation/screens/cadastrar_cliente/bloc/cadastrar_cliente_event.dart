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
