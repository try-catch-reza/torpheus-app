part of 'veiculo_detalhe_bloc.dart';

sealed class VeiculoDetalheState extends Equatable {
  const VeiculoDetalheState({this.veiculo});

  final VeiculoModel? veiculo;

  @override
  List<Object?> get props => [veiculo];
}

final class VeiculoDetalheInitial extends VeiculoDetalheState {
  const VeiculoDetalheInitial();
}

final class VeiculoDetalheLoading extends VeiculoDetalheState {
  const VeiculoDetalheLoading();
}

final class VeiculoDetalheLoaded extends VeiculoDetalheState {
  const VeiculoDetalheLoaded({required super.veiculo});

  @override
  List<Object?> get props => [veiculo];
}

final class VeiculoDetalheError extends VeiculoDetalheState {
  const VeiculoDetalheError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

