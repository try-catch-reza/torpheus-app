part of 'cliente_bloc.dart';

sealed class ClienteState extends Equatable {
  const ClienteState();

  @override
  List<Object?> get props => [];
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
  const ClienteLoaded();

  @override
  List<Object?> get props => [];
}
