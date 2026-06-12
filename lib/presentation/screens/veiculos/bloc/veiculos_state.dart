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
    this.hasEditarVeiculo = false,
    this.veiculoEditar,
  });

  final List<VeiculoModel> veiculos;
  final List<VeiculoModel> veiculosFiltered;

  final CambioVeiculo? cambio;
  final MarcaVeiculo? marca;
  final CombustivelVeiculo? combustivel;
  final TipoVeiculo? tipo;
  final VeiculoModel? veiculoEditar;

  final bool hasCriarVeiculo;
  final bool hasEditarVeiculo;
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
        veiculoEditar,
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
    super.hasEditarVeiculo,
    super.veiculoEditar,
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
        veiculoEditar,
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

final class VeiculosAtualizando extends VeiculosState {
  const VeiculosAtualizando({
    super.veiculos,
    super.cambio,
    super.marca,
    super.combustivel,
    super.tipo,
    super.veiculoEditar,
  });

  @override
  List<Object?> get props => [
        veiculos,
        cambio,
        marca,
        combustivel,
        tipo,
        veiculoEditar,
      ];
}

final class VeiculoAtualizado extends VeiculosState {
  const VeiculoAtualizado();

  @override
  List<Object?> get props => [];
}
