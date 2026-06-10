part of 'usuario_bloc.dart';

sealed class UsuarioState extends Equatable {
  const UsuarioState({
    this.usuarios = const [],
    this.usuariosFiltered = const [],
    this.hasCriarUsuario = false,
    this.search = '',
    this.hasEditarUsuario = false,
    this.perfis = const [],
    this.perfilSelecionado,
  });

  final List<UsuarioModel> usuarios;
  final List<UsuarioModel> usuariosFiltered;

  final List<PerfisModel> perfis;
  final PerfisModel? perfilSelecionado;

  final bool hasCriarUsuario;
  final bool hasEditarUsuario;
  final String search;

  @override
  List<Object?> get props => [
        usuarios,
        hasCriarUsuario,
        search,
        hasEditarUsuario,
      ];
}

final class UsuarioInitial extends UsuarioState {
  const UsuarioInitial();
}

final class UsuarioLoading extends UsuarioState {
  const UsuarioLoading({
    super.usuarios,
    super.usuariosFiltered,
    super.perfilSelecionado,
    super.perfis,
  });
}

final class UsuarioLoaded extends UsuarioState {
  const UsuarioLoaded({
    required super.usuarios,
    required super.usuariosFiltered,
    super.hasCriarUsuario,
    super.search,
    super.hasEditarUsuario,
    super.perfilSelecionado,
    super.perfis,
  });

  @override
  List<Object?> get props => [
        usuarios,
        usuariosFiltered,
        hasCriarUsuario,
        search,
        perfis,
        perfilSelecionado,
      ];
}

final class UsuarioError extends UsuarioState {
  const UsuarioError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

final class UsuarioSalvando extends UsuarioState {
  const UsuarioSalvando({
    super.usuarios,
    super.usuariosFiltered,
    super.perfilSelecionado,
    super.perfis,
  });

  @override
  List<Object?> get props => [
        usuarios,
        usuariosFiltered,
        perfilSelecionado,
        perfis,
      ];
}

final class UsuarioSalvo extends UsuarioState {
  const UsuarioSalvo();
}
