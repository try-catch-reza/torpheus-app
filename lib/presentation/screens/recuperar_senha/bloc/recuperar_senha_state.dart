part of 'recuperar_senha_bloc.dart';

sealed class RecuperarSenhaState extends Equatable {
  const RecuperarSenhaState();

  @override
  List<Object?> get props => [];
}

class RecuperarSenhaInitial extends RecuperarSenhaState {
  const RecuperarSenhaInitial();

  @override
  List<Object?> get props => [];
}

class RecuperarSenhaLoading extends RecuperarSenhaState {
  const RecuperarSenhaLoading();

  @override
  List<Object?> get props => [];
}

class RecuperarSenhaLoaded extends RecuperarSenhaState {
  const RecuperarSenhaLoaded();

  @override
  List<Object?> get props => [];
}

class RecuperarSenhaSuccess extends RecuperarSenhaState {
  final String message;

  const RecuperarSenhaSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class RecuperarSenhaFailure extends RecuperarSenhaState {
  final String error;

  const RecuperarSenhaFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
