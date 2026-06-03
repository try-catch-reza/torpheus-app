part of 'funcionario_detalhe_bloc.dart';

sealed class FuncionarioDetalheEvent extends Equatable {
  const FuncionarioDetalheEvent();

  @override
  List<Object?> get props => [];
}

final class FuncionarioDetalheLoad extends FuncionarioDetalheEvent {
  const FuncionarioDetalheLoad(this.funcionario);

  final FuncionarioModel? funcionario;

  @override
  List<Object?> get props => [funcionario];
}

