part of 'usuario_bloc.dart';

sealed class UsuarioEvent extends Equatable {
  const UsuarioEvent();

  @override
  List<Object?> get props => [];
}

final class UsuariosLoad extends UsuarioEvent {
  const UsuariosLoad();

  @override
  List<Object?> get props => [];
}

final class UsuarioSelecionar extends UsuarioEvent {
  const UsuarioSelecionar(this.usuario);

  final UsuarioModel usuario;

  @override
  List<Object?> get props => [usuario];
}

final class UsuarioSearch extends UsuarioEvent {
  const UsuarioSearch(this.search);

  final String search;

  @override
  List<Object?> get props => [search];
}

final class UsuarioSubmit extends UsuarioEvent {
  const UsuarioSubmit({
    required this.senha,
    required this.nome,
    required this.email,
  });

  final String nome;
  final String email;
  final String senha;

  @override
  List<Object?> get props => [nome, email, senha];
}

final class UsuarioSetPerfil extends UsuarioEvent {
  const UsuarioSetPerfil(this.perfil);

  final PerfisModel perfil;

  @override
  List<Object?> get props => [perfil];
}
