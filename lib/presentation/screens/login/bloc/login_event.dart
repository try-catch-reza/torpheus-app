part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

final class LoginInicializar extends LoginEvent {
  const LoginInicializar();

  @override
  List<Object?> get props => [];
}

final class LoginCarregar extends LoginEvent {
  const LoginCarregar();

  @override
  List<Object?> get props => [];
}

final class LoginEnviar extends LoginEvent {
  const LoginEnviar({required this.email, required this.senha});

  final String email;
  final String senha;

  @override
  List<Object?> get props => [email, senha];
}

final class LoginMostrarSenha extends LoginEvent {
  const LoginMostrarSenha();

  @override
  List<Object?> get props => [];
}

final class LoginLogout extends LoginEvent {
  const LoginLogout();

  @override
  List<Object?> get props => [];
}