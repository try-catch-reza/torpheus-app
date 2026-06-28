part of 'servico_bloc.dart';

sealed class ServicoEvent extends Equatable {
  const ServicoEvent();

  @override
  List<Object?> get props => [];
}

final class ServicoLoad extends ServicoEvent {
  const ServicoLoad({required this.ordemServicoId});

  final String ordemServicoId;

  @override
  List<Object?> get props => [ordemServicoId];
}

final class ServicoSetFuncionario extends ServicoEvent {
  const ServicoSetFuncionario({required this.funcionario});

  final FuncionarioModel funcionario;

  @override
  List<Object?> get props => [funcionario];
}

final class ServicoSubmit extends ServicoEvent {
  const ServicoSubmit({required this.descricao});

  final String descricao;

  @override
  List<Object?> get props => [descricao];
}

final class ServicoUpdate extends ServicoEvent {
  const ServicoUpdate({
    required this.descricao,
    required this.servicoId,
  });

  final String descricao;
  final String servicoId;

  @override
  List<Object?> get props => [descricao, servicoId];
}

final class ServicoTrocarStatus extends ServicoEvent {
  const ServicoTrocarStatus({
    required this.servicoId,
    required this.status,
  });

  final String servicoId;
  final StatusServico status;

  @override
  List<Object?> get props => [servicoId, status];
}

final class ServicoTrocarStatusOS extends ServicoEvent {
  const ServicoTrocarStatusOS({
    required this.status,
  });

  final StatusOrdem status;

  @override
  List<Object?> get props => [status];
}

final class ServicoSelecionarItem extends ServicoEvent {
  const ServicoSelecionarItem({required this.servico});

  final ServicoModel servico;

  @override
  List<Object?> get props => [servico];
}

