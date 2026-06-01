part of 'cadastrar_usuario_bloc.dart';

sealed class CadastrarUsuarioState extends Equatable {
  const CadastrarUsuarioState({
    this.usuarioEditar = const UsuarioModel(),
    this.usuarioId = '',
    this.isEdit = false,
  });

  final UsuarioModel usuarioEditar;
  final bool isEdit;
  final String usuarioId;

  @override
  List<Object?> get props => [
        usuarioEditar,
        isEdit,
        usuarioId,
      ];
}

final class CadastrarUsuarioInitial extends CadastrarUsuarioState {
  const CadastrarUsuarioInitial();

  @override
  List<Object?> get props => [];
}

final class CadastrarUsuarioLoading extends CadastrarUsuarioState {
  const CadastrarUsuarioLoading({
    super.usuarioEditar,
    super.usuarioId,
    super.isEdit,
  });

  @override
  List<Object?> get props => [usuarioEditar, usuarioId, isEdit];
}

final class CadastrarUsuarioLoaded extends CadastrarUsuarioState {
  const CadastrarUsuarioLoaded({
    super.usuarioEditar,
    super.usuarioId,
    super.isEdit,
  });

  @override
  List<Object?> get props => [usuarioEditar, usuarioId, isEdit];
}

final class CadastrarUsuarioSuccess extends CadastrarUsuarioState {
  const CadastrarUsuarioSuccess();

  @override
  List<Object?> get props => [];
}

final class CadastrarUsuarioError extends CadastrarUsuarioState {
  const CadastrarUsuarioError({
    required this.message,
    required super.usuarioId,
    required super.isEdit,
  });

  final String message;

  @override
  List<Object?> get props => [message, usuarioId, isEdit];
}

final class CadastrarUsuarioEditando extends CadastrarUsuarioState {
  const CadastrarUsuarioEditando({
    required super.usuarioEditar,
    required super.usuarioId,
    required super.isEdit,
  });

  @override
  List<Object?> get props => [usuarioEditar, usuarioId, isEdit];
}

final class CadastrarUsuarioAtualizado extends CadastrarUsuarioState {
  const CadastrarUsuarioAtualizado();

  @override
  List<Object?> get props => [];
}

