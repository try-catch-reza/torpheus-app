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
