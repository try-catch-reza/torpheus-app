part of 'servico_bloc.dart';

sealed class ServicoState extends Equatable {
  const ServicoState({
    this.ordemServico,
    this.funcionarios = const [],
    this.funcionarioSelecionado,
  });

  final OrdemServicoModel? ordemServico;
  final List<FuncionarioModel> funcionarios;

  final FuncionarioModel? funcionarioSelecionado;

  @override
  List<Object?> get props => [
        ordemServico,
        funcionarios,
        funcionarioSelecionado,
      ];
}

final class ServicoInitial extends ServicoState {
  const ServicoInitial();
}

final class ServicoLoading extends ServicoState {
  const ServicoLoading({super.funcionarioSelecionado, super.ordemServico});

  @override
  List<Object?> get props => [funcionarioSelecionado, ordemServico];
}

final class ServicoLoaded extends ServicoState {
  const ServicoLoaded({
    required super.ordemServico,
    required super.funcionarios,
    super.funcionarioSelecionado,
  });

  @override
  List<Object?> get props => [
        ordemServico,
        funcionarios,
        funcionarioSelecionado,
      ];
}

final class ServicoFail extends ServicoState {
  const ServicoFail({required this.message, required super.ordemServico});

  final String message;

  @override
  List<Object?> get props => [message, ordemServico];
}

final class ServicoSalvo extends ServicoState {
  const ServicoSalvo({
    required super.ordemServico,
    required super.funcionarios,
  });

  @override
  List<Object?> get props => [ordemServico, funcionarios];
}

final class ServicoAtualizado extends ServicoState {
  const ServicoAtualizado({required super.ordemServico});

  @override
  List<Object?> get props => [ordemServico];
}

final class ServicoConcluido extends ServicoState {
  const ServicoConcluido({required super.ordemServico});

  @override
  List<Object?> get props => [ordemServico];
}

final class ServicoSelecionado extends ServicoState {
  const ServicoSelecionado({
    required super.ordemServico,
    required super.funcionarios,
    super.funcionarioSelecionado,
    required this.servicoSelecionado,
  });

  final ServicoModel servicoSelecionado;

  @override
  List<Object?> get props => [
        ordemServico,
        funcionarios,
        funcionarioSelecionado,
        servicoSelecionado,
      ];
}

