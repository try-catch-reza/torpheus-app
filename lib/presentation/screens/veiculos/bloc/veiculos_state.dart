part of 'veiculos_bloc.dart';

sealed class VeiculosState extends Equatable {
  const VeiculosState({
    this.veiculos = const [],
    this.veiculosFiltered = const [],
    this.cambio,
    this.marca,
    this.combustivel,
    this.tipo,
    this.hasCriarVeiculo = false,
    this.search = '',
  });

  final List<VeiculoModel> veiculos;
  final List<VeiculoModel> veiculosFiltered;

  final CambioVeiculo? cambio;
  final MarcaVeiculo? marca;
  final CombustivelVeiculo? combustivel;
  final TipoVeiculo? tipo;

  final bool hasCriarVeiculo;
  final String search;

  @override
  List<Object?> get props => [
        veiculos,
        cambio,
        marca,
        combustivel,
        tipo,
        hasCriarVeiculo,
        search,
      ];
}

final class VeiculosInitial extends VeiculosState {
  const VeiculosInitial();

  @override
  List<Object?> get props => [];
}

final class VeiculosLoading extends VeiculosState {
  const VeiculosLoading({
    super.veiculos,
    super.cambio,
    super.marca,
    super.combustivel,
    super.tipo,
  });

  @override
  List<Object?> get props => [veiculos, cambio, marca, combustivel, tipo];
}

final class VeiculosLoaded extends VeiculosState {
  const VeiculosLoaded({
    required super.veiculos,
    required super.veiculosFiltered,
    super.cambio,
    super.marca,
    super.combustivel,
    super.tipo,
    super.hasCriarVeiculo,
    super.search,
  });

  @override
  List<Object?> get props => [
        veiculos,
        veiculosFiltered,
        cambio,
        marca,
        combustivel,
        tipo,
        hasCriarVeiculo,
        search,
      ];
}

final class VeiculosError extends VeiculosState {
  const VeiculosError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

final class VeiculoSuccess extends VeiculosState {
  const VeiculoSuccess();

  @override
  List<Object?> get props => [];
}

final class VeiculosSalvando extends VeiculosState {
  const VeiculosSalvando({
    super.veiculos,
    super.cambio,
    super.marca,
    super.combustivel,
    super.tipo,
  });

  @override
  List<Object?> get props => [veiculos, cambio, marca, combustivel, tipo];
}
