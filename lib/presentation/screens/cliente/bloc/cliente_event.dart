part of 'cliente_bloc.dart';

sealed class ClienteEvent extends Equatable {
  const ClienteEvent();

  @override
  List<Object?> get props => [];
}

final class ClientesLoad extends ClienteEvent {
  const ClientesLoad();

  @override
  List<Object?> get props => [];
}

final class ClienteSearch extends ClienteEvent {
  const ClienteSearch(this.query);

  final String query;

  @override
  List<Object?> get props => [query];
}

final class ClienteSelecionar extends ClienteEvent {
  const ClienteSelecionar(this.cliente);

  final ClienteModel cliente;

  @override
  List<Object?> get props => [cliente];
}

final class ClienteSetCEP extends ClienteEvent {
  const ClienteSetCEP(this.cep);

  final String cep;

  @override
  List<Object?> get props => [cep];
}

final class ClienteCadastrar extends ClienteEvent {
  const ClienteCadastrar();

  @override
  List<Object?> get props => [];
}
