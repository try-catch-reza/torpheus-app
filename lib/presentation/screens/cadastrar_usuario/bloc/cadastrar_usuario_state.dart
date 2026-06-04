part of 'cadastrar_usuario_bloc.dart';

sealed class CadastrarUsuarioState extends Equatable {
  const CadastrarUsuarioState({
    this.perfis = const [],
    this.perfilSelecionado,
  });

  final List<PerfisModel> perfis;
  final PerfisModel? perfilSelecionado;

  @override
  List<Object?> get props => [perfis, perfilSelecionado];
}

final class CadastrarUsuarioInitial extends CadastrarUsuarioState {
  const CadastrarUsuarioInitial();

  @override
  List<Object?> get props => [];
}

final class CadastrarUsuarioLoading extends CadastrarUsuarioState {
  const CadastrarUsuarioLoading({super.perfilSelecionado});

  @override
  List<Object?> get props => [perfilSelecionado];
}

final class CadastrarUsuarioLoaded extends CadastrarUsuarioState {
  const CadastrarUsuarioLoaded({
    super.perfis,
    super.perfilSelecionado,
  });

  @override
  List<Object?> get props => [perfis, perfilSelecionado];
}

final class CadastrarUsuarioSuccess extends CadastrarUsuarioState {
  const CadastrarUsuarioSuccess();

  @override
  List<Object?> get props => [];
}

final class CadastrarUsuarioError extends CadastrarUsuarioState {
  const CadastrarUsuarioError({
    required this.message,
  });

  final String message;

  @override
  List<Object?> get props => [message];
}
