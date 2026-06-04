part of 'painel_bloc.dart';

sealed class PainelState extends Equatable {
  const PainelState({
    this.image,
    this.email = '',
    this.nome = '',
    this.cargo = '',
  });

  final File? image;
  final String nome;
  final String email;
  final String cargo;

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
  const PainelLoaded({required super.email, required super.nome, required super.cargo});

  @override
  List<Object?> get props => [email, nome];
}

final class PainelFail extends PainelState {
  const PainelFail(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
