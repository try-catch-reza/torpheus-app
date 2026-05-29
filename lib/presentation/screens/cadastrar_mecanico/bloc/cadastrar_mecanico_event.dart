part of 'cadastrar_mecanico_bloc.dart';

sealed class CadastrarMecanicoEvent extends Equatable {
  const CadastrarMecanicoEvent();

  @override
  List<Object?> get props => [];
}

final class CadastrarMecanicoLoad extends CadastrarMecanicoEvent {
  const CadastrarMecanicoLoad();

  @override
  List<Object?> get props => [];
}

final class CadastrarMecanicoSubmit extends CadastrarMecanicoEvent {
  const CadastrarMecanicoSubmit({required this.funcionario});

  final FuncionarioModel funcionario;

  @override
  List<Object?> get props => [funcionario];
}


