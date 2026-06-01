part of 'painel_bloc.dart';

sealed class PainelState extends Equatable {
  const PainelState({this.image});

  final File? image;

  @override
  List<Object?> get props => [image];
}

final class PainelInitial extends PainelState {
  const PainelInitial();

  @override
  List<Object?> get props => [];
}

final class PainelLoading extends PainelState {
  const PainelLoading();

  @override
  List<Object?> get props => [];
}

final class PainelLoaded extends PainelState {
  const PainelLoaded({super.image});

  @override
  List<Object?> get props => [image];
}

final class PainelFail extends PainelState {
  const PainelFail(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}