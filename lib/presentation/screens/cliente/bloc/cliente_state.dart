part of 'cliente_bloc.dart';

sealed class ClienteState extends Equatable {
  const ClienteState({
    this.clientes = const [],
    this.clientesFiltered = const [],
    this.endereco = const EnderecoModel(),
    this.clienteSelecionado,
    this.hasCriarCliente = false,
    this.search = '',
  });

  final List<ClienteModel> clientes;
  final List<ClienteModel> clientesFiltered;
  final EnderecoModel endereco;
  final ClienteModel? clienteSelecionado;

  final bool hasCriarCliente;
  final String search;

  @override
  List<Object?> get props => [
        clientes,
        endereco,
        clienteSelecionado,
        hasCriarCliente,
        search,
      ];
}

final class ClienteInitial extends ClienteState {
  const ClienteInitial();

  @override
  List<Object?> get props => [];
}

final class ClienteLoading extends ClienteState {
  const ClienteLoading({
    super.clientes,
    super.clientesFiltered,
    super.endereco,
  });

  @override
  List<Object?> get props => [clientes, clientesFiltered, endereco];
}

final class ClienteLoaded extends ClienteState {
  const ClienteLoaded({
    required super.clientes,
    required super.clientesFiltered,
    super.endereco,
    super.hasCriarCliente,
    super.search,
  });

  @override
  List<Object?> get props => [clientes, clientesFiltered, endereco, hasCriarCliente, search];
}

final class ClienteError extends ClienteState {
  const ClienteError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

final class ClienteSelecionado extends ClienteState {
  const ClienteSelecionado({
    required super.clientes,
    required super.clienteSelecionado,
  });

  @override
  List<Object?> get props => [clientes, clienteSelecionado];
}

final class ClienteCadastrando extends ClienteState {
  const ClienteCadastrando();

  @override
  List<Object?> get props => [];
}

final class ClienteCEPSetado extends ClienteState {
  const ClienteCEPSetado({required super.clientes, required super.endereco, super.clientesFiltered});

  @override
  List<Object?> get props => [clientes, endereco, clientesFiltered];
}

final class ClienteAtualizando extends ClienteState {
  const ClienteAtualizando({
    required super.clienteSelecionado,
  });

  @override
  List<Object?> get props => [clienteSelecionado];
}
