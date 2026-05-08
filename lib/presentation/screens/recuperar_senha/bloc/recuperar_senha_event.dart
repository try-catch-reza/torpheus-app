part of 'recuperar_senha_bloc.dart';

sealed class RecuperarSenhaEvent extends Equatable {
  const RecuperarSenhaEvent();

  @override
  List<Object?> get props => [];
}

class RecuperarSenhaLoad extends RecuperarSenhaEvent {
  const RecuperarSenhaLoad();

  @override
  List<Object?> get props => [];
}

class RecuperarSenhaSolicitar extends RecuperarSenhaEvent {
  final String email;

  const RecuperarSenhaSolicitar({required this.email});

  @override
  List<Object?> get props => [email];
}
