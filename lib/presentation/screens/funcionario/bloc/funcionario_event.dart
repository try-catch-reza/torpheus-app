part of 'funcionario_bloc.dart';

sealed class FuncionarioEvent extends Equatable {
  const FuncionarioEvent();

  @override
  List<Object?> get props => [];
}

class FuncionarioLoad extends FuncionarioEvent {
  const FuncionarioLoad();

  @override
  List<Object?> get props => [];
}

final class FuncionarioCadastrar extends FuncionarioEvent {
  const FuncionarioCadastrar();

  @override
  List<Object?> get props => [];
}

final class FuncionarioSearch extends FuncionarioEvent {
  const FuncionarioSearch(this.search);

  final String search;

  @override
  List<Object?> get props => [search];
}

