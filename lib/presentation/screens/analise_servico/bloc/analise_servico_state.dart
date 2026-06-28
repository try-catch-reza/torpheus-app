part of 'analise_servico_bloc.dart';

sealed class AnaliseServicoState extends Equatable {
  const AnaliseServicoState({
    this.servico,
    this.funcionario,
    this.funcionarios = const [],
    this.data,
    this.ordemServico,
  });

  final ServicoModel? servico;
  final FuncionarioModel? funcionario;
  final List<FuncionarioModel> funcionarios;
  final DateTime? data;
  final OrdemServicoModel? ordemServico;

  @override
  List<Object?> get props => [
        servico,
        funcionario,
        funcionarios,
        data,
        ordemServico,
      ];
}

final class AnaliseServicoInitial extends AnaliseServicoState {
  const AnaliseServicoInitial();
}

final class AnaliseServicoLoading extends AnaliseServicoState {
  const AnaliseServicoLoading({super.servico, super.funcionario});

  @override
  List<Object?> get props => [servico];
}

final class AnaliseServicoLoaded extends AnaliseServicoState {
  const AnaliseServicoLoaded({
    required super.servico,
    required super.funcionario,
    required super.funcionarios,
    required super.data,
    required super.ordemServico,
  });

  @override
  List<Object?> get props => [
        servico,
        funcionario,
        funcionarios,
        data,
        ordemServico,
      ];
}

final class AnaliseServicoFail extends AnaliseServicoState {
  const AnaliseServicoFail({
    required this.message,
    super.servico,
    super.funcionarios,
    super.ordemServico,
  });

  final String message;

  @override
  List<Object?> get props => [message, servico, funcionarios, ordemServico];
}

final class AnaliseServicoHoraRegistrada extends AnaliseServicoState {
  const AnaliseServicoHoraRegistrada({
    required super.servico,
    required super.funcionario,
    required super.ordemServico,
    required super.funcionarios,
  });

  @override
  List<Object?> get props => [servico, funcionario, ordemServico, funcionarios];
}
