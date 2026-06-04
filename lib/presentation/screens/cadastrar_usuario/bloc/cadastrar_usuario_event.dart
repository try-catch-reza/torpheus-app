part of 'cadastrar_usuario_bloc.dart';

sealed class CadastrarUsuarioEvent extends Equatable {
  const CadastrarUsuarioEvent();

  @override
  List<Object?> get props => [];
}

final class CadastrarUsuarioLoad extends CadastrarUsuarioEvent {
  const CadastrarUsuarioLoad();

  @override
  List<Object?> get props => [];
}

final class CadastrarUsuarioSubmit extends CadastrarUsuarioEvent {
  const CadastrarUsuarioSubmit({
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

final class CadastrarUsuarioUpdate extends CadastrarUsuarioEvent {
  const CadastrarUsuarioUpdate({required this.usuario});

  final UsuarioModel usuario;

  @override
  List<Object?> get props => [usuario];
}

final class CadastrarUsuarioSetPerfil extends CadastrarUsuarioEvent {
  const CadastrarUsuarioSetPerfil(this.perfil);

  final PerfisModel perfil;

  @override
  List<Object?> get props => [perfil];
}
