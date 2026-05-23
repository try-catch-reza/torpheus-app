part of 'cliente_bloc.dart';

sealed class ClienteState extends Equatable {
  const ClienteState({this.clientes = const []});

  final List<ClienteModel> clientes;

  @override
  List<Object?> get props => [clientes];
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
  const ClienteLoaded({required super.clientes});

  @override
  List<Object?> get props => [clientes];
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
