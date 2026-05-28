part of 'cliente_bloc.dart';

sealed class ClienteState extends Equatable {
  const ClienteState({
    this.clientes = const [],
    this.endereco = const EnderecoModel(),
  });

  final List<ClienteModel> clientes;
  final EnderecoModel endereco;

  @override
  List<Object?> get props => [clientes, endereco];
}

final class ClienteInitial extends ClienteState {
  const ClienteInitial();

  @override
  List<Object?> get props => [];
}

final class ClienteLoading extends ClienteState {
  const ClienteLoading();

  @override
  List<Object?> get props => [];
}

final class ClienteLoaded extends ClienteState {
  const ClienteLoaded({required super.clientes, super.endereco});

  @override
  List<Object?> get props => [clientes, endereco];
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
    required this.clienteSelecionado,
  });

  final ClienteModel clienteSelecionado;

  @override
  List<Object?> get props => [clientes, clienteSelecionado];
}

final class ClienteCadastrando extends ClienteState {
  const ClienteCadastrando();

  @override
  List<Object?> get props => [];
}

final class ClienteCEPSetado extends ClienteState {
  const ClienteCEPSetado({required super.clientes, required super.endereco});

  @override
  List<Object?> get props => [clientes, endereco];
}
