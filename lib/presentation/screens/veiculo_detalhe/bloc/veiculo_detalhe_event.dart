part of 'veiculo_detalhe_bloc.dart';

sealed class VeiculoDetalheEvent extends Equatable {
  const VeiculoDetalheEvent();

  @override
  List<Object?> get props => [];
}

final class VeiculoDetalheLoad extends VeiculoDetalheEvent {
  const VeiculoDetalheLoad(this.veiculo);

  final VeiculoModel? veiculo;

  @override
  List<Object?> get props => [veiculo];
}

