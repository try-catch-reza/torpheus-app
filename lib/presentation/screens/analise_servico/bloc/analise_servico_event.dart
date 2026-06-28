part of 'analise_servico_bloc.dart';

sealed class AnaliseServicoEvent extends Equatable {
  const AnaliseServicoEvent();

  @override
  List<Object?> get props => [];
}

final class AnaliseServicoLoad extends AnaliseServicoEvent {
  const AnaliseServicoLoad({
    required this.ordemServicoId,
    required this.servicoId,
  });

  final String ordemServicoId;
  final String servicoId;

  @override
  List<Object?> get props => [ordemServicoId, servicoId];
}

final class AnaliseServicoRegistrarHora extends AnaliseServicoEvent {
  const AnaliseServicoRegistrarHora({
    required this.nota,
    required this.hora,
    required this.minuto,
  });

  final String nota;
  final String hora;
  final String minuto;

  @override
  List<Object?> get props => [nota, hora, minuto];
}

final class AnaliseServicoTrocarFuncionario extends AnaliseServicoEvent {
  const AnaliseServicoTrocarFuncionario({
    required this.ordemServicoId,
    required this.servicoId,
    required this.funcionarioId,
  });

  final String ordemServicoId;
  final String servicoId;
  final String funcionarioId;

  @override
  List<Object?> get props => [ordemServicoId, servicoId, funcionarioId];
}

final class AnaliseServicoSetFuncionario extends AnaliseServicoEvent {
  const AnaliseServicoSetFuncionario({
    required this.funcionario,
  });

  final FuncionarioModel funcionario;

  @override
  List<Object?> get props => [funcionario];
}

final class AnaliseServicoSetData extends AnaliseServicoEvent {
  const AnaliseServicoSetData({
    required this.data,
  });

  final DateTime data;

  @override
  List<Object?> get props => [data];
}
