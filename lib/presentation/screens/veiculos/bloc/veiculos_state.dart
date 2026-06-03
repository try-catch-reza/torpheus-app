part of 'veiculos_bloc.dart';

sealed class VeiculosState extends Equatable {
  const VeiculosState({
    this.veiculos = const [],
    this.cambio = '',
    this.marca = '',
    this.combustivel = '',
    this.tipo = '',
  });

  final List<VeiculoModel> veiculos;

  final String cambio;
  final String marca;
  final String combustivel;
  final String tipo;

  @override
  List<Object?> get props => [
        veiculos,
        cambio,
        marca,
        combustivel,
        tipo,
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
    super.cambio,
    super.marca,
    super.combustivel,
    super.tipo,
  });

  @override
  List<Object?> get props => [veiculos, cambio, marca, combustivel, tipo];
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
