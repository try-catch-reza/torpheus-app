part of 'painel_bloc.dart';

sealed class PainelEvent extends Equatable {
  const PainelEvent();

  @override
  List<Object?> get props => [];
}

final class PainelCarregar extends PainelEvent {
  const PainelCarregar();

  @override
  List<Object?> get props => [];
}

final class PainelAbrirCamera extends PainelEvent {
  const PainelAbrirCamera();

  @override
  List<Object?> get props => [];
}

final class PainelAbrirGaleria extends PainelEvent {
  const PainelAbrirGaleria();

  @override
  List<Object?> get props => [];
}