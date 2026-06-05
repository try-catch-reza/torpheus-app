part of 'usuario_bloc.dart';

sealed class UsuarioState extends Equatable {
  const UsuarioState({
    this.usuarios = const [],
    this.hasCriarUsuario = false,
  });

  final List<UsuarioModel> usuarios;
  final bool hasCriarUsuario;

  @override
  List<Object?> get props => [usuarios, hasCriarUsuario];
}

final class UsuarioInitial extends UsuarioState {
  const UsuarioInitial();
}

final class UsuarioLoading extends UsuarioState {
  const UsuarioLoading();
}

final class UsuarioLoaded extends UsuarioState {
  const UsuarioLoaded({
    required super.usuarios,
    required super.hasCriarUsuario,
  });

  @override
  List<Object?> get props => [usuarios, hasCriarUsuario];
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
