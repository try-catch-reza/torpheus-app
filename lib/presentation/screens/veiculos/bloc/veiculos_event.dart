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
