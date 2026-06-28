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
    required this.ordemServicoId,
    required this.servicoId,
    required this.durationMinutes,
    required this.performedAt,
    this.note,
  });

  final String ordemServicoId;
  final String servicoId;
  final int durationMinutes;
  final DateTime performedAt;
  final String? note;

  @override
  List<Object?> get props => [
        ordemServicoId,
        servicoId,
        durationMinutes,
        performedAt,
        note,
      ];
}

