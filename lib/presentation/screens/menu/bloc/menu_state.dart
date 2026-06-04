part of 'menu_bloc.dart';

sealed class MenuState extends Equatable {
  const MenuState({
    this.indexScreen = 0,
    this.nome = '',
    this.permissoesUsuarios = const [],
  });

  final int indexScreen;
  final String nome;
  final List<String> permissoesUsuarios;

  @override
  List<Object?> get props => [indexScreen, nome];
}

final class MenuInitial extends MenuState {
  const MenuInitial();

  @override
  List<Object?> get props => [];
}

final class MenuLoading extends MenuState {
  const MenuLoading();

  @override
  List<Object?> get props => [];
}

final class MenuLoaded extends MenuState {
  const MenuLoaded({
    required super.indexScreen,
    required super.nome,
    required super.permissoesUsuarios,
  });

  @override
  List<Object?> get props => [indexScreen, nome];
}

final class MenuFail extends MenuState {
  const MenuFail(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
