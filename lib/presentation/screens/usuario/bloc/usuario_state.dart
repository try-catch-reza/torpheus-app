part of 'usuario_bloc.dart';

sealed class UsuarioState extends Equatable {
  const UsuarioState({
    this.usuarios = const [],
    this.usuariosFiltered = const [],
    this.hasCriarUsuario = false,
    this.search = '',
  });

  final List<UsuarioModel> usuarios;
  final List<UsuarioModel> usuariosFiltered;
  final bool hasCriarUsuario;
  final String search;

  @override
  List<Object?> get props => [usuarios, hasCriarUsuario, search];
}

final class UsuarioInitial extends UsuarioState {
  const UsuarioInitial();
}

final class UsuarioLoading extends UsuarioState {
  const UsuarioLoading({
    super.usuarios,
    super.usuariosFiltered,
  });
}

final class UsuarioLoaded extends UsuarioState {
  const UsuarioLoaded({
    required super.usuarios,
    required super.usuariosFiltered,
    super.hasCriarUsuario,
    super.search,
  });

  @override
  List<Object?> get props => [usuarios, usuariosFiltered, hasCriarUsuario, search];
}

final class UsuarioError extends UsuarioState {
  const UsuarioError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

final class UsuarioSelecionado extends UsuarioState {
  const UsuarioSelecionado({
    required this.usuarios,
    required this.usuarioSelecionado,
  }) : super(usuarios: usuarios);

  final List<UsuarioModel> usuarios;
  final UsuarioModel usuarioSelecionado;

  @override
  List<Object?> get props => [usuarios, usuarioSelecionado];
}
