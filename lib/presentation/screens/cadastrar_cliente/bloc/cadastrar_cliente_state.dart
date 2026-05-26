part of 'cadastrar_cliente_bloc.dart';

sealed class CadastrarClienteState extends Equatable {
  const CadastrarClienteState();

  @override
  List<Object?> get props => [];
}

final class CadastrarClienteInitial extends CadastrarClienteState {
  const CadastrarClienteInitial();

  @override
  List<Object?> get props => [];
}

final class CadastrarClienteLoading extends CadastrarClienteState {
  const CadastrarClienteLoading();

  @override
  List<Object?> get props => [];
}

final class CadastrarClienteLoaded extends CadastrarClienteState {
  const CadastrarClienteLoaded();

  @override
  List<Object?> get props => [];
}

final class CadastrarClienteSuccess extends CadastrarClienteState {
  const CadastrarClienteSuccess();

  @override
  List<Object?> get props => [];
}

final class CadastrarClienteError extends CadastrarClienteState {
  const CadastrarClienteError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
