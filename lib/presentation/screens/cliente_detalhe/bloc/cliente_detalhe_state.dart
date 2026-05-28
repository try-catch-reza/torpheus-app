part of 'cliente_detalhe_bloc.dart';

sealed class ClienteDetalheState extends Equatable {
  const ClienteDetalheState({this.cliente});

  final ClienteModel? cliente;

  @override
  List<Object?> get props => [cliente];
}

final class ClienteDetalheInitial extends ClienteDetalheState {
  const ClienteDetalheInitial();
}

final class ClienteDetalheLoading extends ClienteDetalheState {
  const ClienteDetalheLoading();
}

final class ClienteDetalheLoaded extends ClienteDetalheState {
  const ClienteDetalheLoaded({required super.cliente});

  @override
  List<Object?> get props => [cliente];
}

final class ClienteDetalheError extends ClienteDetalheState {
  const ClienteDetalheError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
