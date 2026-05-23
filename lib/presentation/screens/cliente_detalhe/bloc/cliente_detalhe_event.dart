part of 'cliente_detalhe_bloc.dart';

sealed class ClienteDetalheEvent extends Equatable {
  const ClienteDetalheEvent();

  @override
  List<Object?> get props => [];
}

final class ClienteDetalheLoad extends ClienteDetalheEvent {
  const ClienteDetalheLoad(this.cliente);

  final ClienteModel? cliente;

  @override
  List<Object?> get props => [cliente];
}
