part of 'analise_servico_bloc.dart';

sealed class AnaliseServicoState extends Equatable {
  const AnaliseServicoState({this.servico, this.funcionario});

  final ServicoModel? servico;
  final FuncionarioModel? funcionario;

  @override
  List<Object?> get props => [servico, funcionario];
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
  });

  @override
  List<Object?> get props => [servico, funcionario];
}

final class AnaliseServicoFail extends AnaliseServicoState {
  const AnaliseServicoFail({required this.message, super.servico});

  final String message;

  @override
  List<Object?> get props => [message, servico];
}

final class AnaliseServicoHoraRegistrada extends AnaliseServicoState {
  const AnaliseServicoHoraRegistrada({super.servico, super.funcionario});

  @override
  List<Object?> get props => [servico, funcionario];
}
