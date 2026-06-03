part of 'veiculos_bloc.dart';

sealed class VeiculosEvent extends Equatable {
  const VeiculosEvent();

  @override
  List<Object?> get props => [];
}

final class VeiculosLoad extends VeiculosEvent {
  const VeiculosLoad();

  @override
  List<Object?> get props => [];
}

final class VeiculoSubmit extends VeiculosEvent {
  const VeiculoSubmit({
    required this.placa,
    required this.modelo,
    required this.motor,
    required this.ano,
  });

  final String placa;
  final String modelo;
  final String motor;
  final String ano;

  @override
  List<Object?> get props => [placa, modelo, motor, ano];
}

final class VeiculoUpdate extends VeiculosEvent {
  const VeiculoUpdate({required this.veiculo});

  final VeiculoModel veiculo;

  @override
  List<Object?> get props => [veiculo];
}

final class VeiculoSetTipo extends VeiculosEvent {
  const VeiculoSetTipo(this.tipo);

  final String tipo;

  @override
  List<Object?> get props => [tipo];
}

final class VeiculoSetMarca extends VeiculosEvent {
  const VeiculoSetMarca(this.marca);

  final String marca;

  @override
  List<Object?> get props => [marca];
}

final class VeiculoSetCambio extends VeiculosEvent {
  const VeiculoSetCambio(this.cambio);

  final String cambio;

  @override
  List<Object?> get props => [cambio];
}

final class VeiculoSetCombustivel extends VeiculosEvent {
  const VeiculoSetCombustivel(this.combustivel);

  final String combustivel;

  @override
  List<Object?> get props => [combustivel];
}
