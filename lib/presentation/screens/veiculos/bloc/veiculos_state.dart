part of 'veiculos_bloc.dart';

sealed class VeiculosState extends Equatable {
  const VeiculosState();

  @override
  List<Object?> get props => [];
}

final class VeiculosInitial extends VeiculosState {
  const VeiculosInitial();

  @override
  List<Object?> get props => [];
}

final class VeiculosLoading extends VeiculosState {
  const VeiculosLoading();

  @override
  List<Object?> get props => [];
}

final class VeiculosLoaded extends VeiculosState {
  const VeiculosLoaded();

  @override
  List<Object?> get props => [];
}
