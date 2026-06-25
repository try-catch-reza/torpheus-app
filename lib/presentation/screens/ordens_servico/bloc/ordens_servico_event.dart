part of 'ordens_servico_bloc.dart';

sealed class OrdensServicoEvent extends Equatable {
  const OrdensServicoEvent();

  @override
  List<Object?> get props => [];
}

final class OrdensServicoLoad extends OrdensServicoEvent {
  const OrdensServicoLoad();

  @override
  List<Object?> get props => [];
}

final class OrdensServicoSearch extends OrdensServicoEvent {
  const OrdensServicoSearch(this.search);

  final String search;

  @override
  List<Object?> get props => [search];
}

final class OrdensServicoSetCliente extends OrdensServicoEvent {
  const OrdensServicoSetCliente(this.cliente);

  final ClienteModel cliente;

  @override
  List<Object?> get props => [cliente];
}

final class OrdensServicoSetVeiculo extends OrdensServicoEvent {
  const OrdensServicoSetVeiculo(this.veiculo);

  final VeiculoModel veiculo;

  @override
  List<Object?> get props => [veiculo];
}

final class OrdensServicoSubmit extends OrdensServicoEvent {
  const OrdensServicoSubmit(this.descricao);

  final String descricao;

  @override
  List<Object?> get props => [descricao];
}

final class OrdensServicoSetFuncionario extends OrdensServicoEvent {
  const OrdensServicoSetFuncionario(this.funcionario);

  final FuncionarioModel funcionario;

  @override
  List<Object?> get props => [funcionario];
}

final class OrdensServicoAddServico extends OrdensServicoEvent {
  const OrdensServicoAddServico({
    required this.descricao,
    required this.id,
  });

  final String descricao;
  final String id;

  @override
  List<Object?> get props => [descricao, id];
}

final class OrdensServicoSelecionar extends OrdensServicoEvent {
  const OrdensServicoSelecionar(this.ordemServico);

  final OrdemServicoModel ordemServico;

  @override
  List<Object?> get props => [ordemServico];
}

