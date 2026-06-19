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
