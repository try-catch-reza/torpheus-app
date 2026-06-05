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
