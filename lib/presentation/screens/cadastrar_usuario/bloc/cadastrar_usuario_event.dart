part of 'cadastrar_usuario_bloc.dart';

sealed class CadastrarUsuarioEvent extends Equatable {
  const CadastrarUsuarioEvent();

  @override
  List<Object?> get props => [];
}

final class CadastrarUsuarioLoad extends CadastrarUsuarioEvent {
  const CadastrarUsuarioLoad({required this.isEdit, required this.usuarioId});

  final bool isEdit;
  final String usuarioId;

  @override
  List<Object?> get props => [isEdit, usuarioId];
}

final class CadastrarUsuarioSubmit extends CadastrarUsuarioEvent {
  const CadastrarUsuarioSubmit({required this.usuario});

  final UsuarioModel usuario;

  @override
  List<Object?> get props => [usuario];
}

final class CadastrarUsuarioUpdate extends CadastrarUsuarioEvent {
  const CadastrarUsuarioUpdate({required this.usuario});

  final UsuarioModel usuario;

  @override
  List<Object?> get props => [usuario];
}

final class CadastrarUsuarioSetAtivo extends CadastrarUsuarioEvent {
  const CadastrarUsuarioSetAtivo(this.isAtivo);

  final bool isAtivo;

  @override
  List<Object?> get props => [isAtivo];
}

