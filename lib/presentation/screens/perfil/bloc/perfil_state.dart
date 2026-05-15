part of 'perfil_bloc.dart';

sealed class PerfilState extends Equatable {
  const PerfilState({this.nome = '', this.email = ''});

  final String nome;
  final String email;

  @override
  List<Object?> get props => [nome, email];
}

final class PerfilInitial extends PerfilState {
  const PerfilInitial();

  @override
  List<Object?> get props => [];
}

final class PerfilLoading extends PerfilState {
  const PerfilLoading();

  @override
  List<Object?> get props => [];
}

final class PerfilLoaded extends PerfilState {
  const PerfilLoaded({required super.email, required super.nome});

  @override
  List<Object?> get props => [email, nome];
}

final class PerfilFail extends PerfilState {
  const PerfilFail(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}