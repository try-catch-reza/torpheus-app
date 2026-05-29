part of 'cadastrar_mecanico_bloc.dart';

sealed class CadastrarMecanicoState extends Equatable {
  const CadastrarMecanicoState();

  @override
  List<Object?> get props => [];
}

final class CadastrarMecanicoInitial extends CadastrarMecanicoState {
  const CadastrarMecanicoInitial();
}

final class CadastrarMecanicoLoading extends CadastrarMecanicoState {
  const CadastrarMecanicoLoading();
}

final class CadastrarMecanicoLoaded extends CadastrarMecanicoState {
  const CadastrarMecanicoLoaded();
}

final class CadastrarMecanicoSuccess extends CadastrarMecanicoState {
  const CadastrarMecanicoSuccess();
}

final class CadastrarMecanicoError extends CadastrarMecanicoState {
  const CadastrarMecanicoError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
