part of 'ordens_servico_bloc.dart';

sealed class OrdensServicoState extends Equatable {
  const OrdensServicoState({
    this.ordensServico = const [],
    this.ordensServicoFiltered = const [],
    this.hasPodeCriar = false,
    this.veiculos = const [],
    this.clientes = const [],
    this.funcionarios = const [],
    this.clienteSelecionado,
    this.veiculoSelecionado,
    this.funcionarioSelecionado,
  });

  final List<OrdemServicoModel> ordensServico;
  final List<OrdemServicoModel> ordensServicoFiltered;
  final List<ClienteModel> clientes;
  final List<VeiculoModel> veiculos;
  final List<FuncionarioModel> funcionarios;

  final ClienteModel? clienteSelecionado;
  final VeiculoModel? veiculoSelecionado;
  final FuncionarioModel? funcionarioSelecionado;

  final bool hasPodeCriar;

  @override
  List<Object?> get props => [
        ordensServico,
        ordensServicoFiltered,
        hasPodeCriar,
        clientes,
        veiculos,
        clienteSelecionado,
        veiculoSelecionado,
        funcionarios,
        funcionarioSelecionado,
      ];
}

final class OrdensServicoInitial extends OrdensServicoState {
  const OrdensServicoInitial();

  @override
  List<Object?> get props => [];
}

final class OrdensServicoLoading extends OrdensServicoState {
  const OrdensServicoLoading();

  @override
  List<Object?> get props => [];
}

final class OrdensServicoLoaded extends OrdensServicoState {
  const OrdensServicoLoaded({
    required super.ordensServico,
    required super.ordensServicoFiltered,
    required super.hasPodeCriar,
    required super.clientes,
    required super.veiculos,
    required super.funcionarios,
    super.clienteSelecionado,
    super.veiculoSelecionado,
    super.funcionarioSelecionado,
  });

  @override
  List<Object?> get props => [
        ordensServico,
        ordensServicoFiltered,
        hasPodeCriar,
        clientes,
        veiculos,
        clienteSelecionado,
        veiculoSelecionado,
        funcionarioSelecionado,
        funcionarios,
      ];
}

final class OrdensServicoError extends OrdensServicoState {
  final String message;

  const OrdensServicoError({required this.message});

  @override
  List<Object?> get props => [message];
}

final class OrdensServicoSalvando extends OrdensServicoState {
  const OrdensServicoSalvando({
    required super.clienteSelecionado,
    required super.veiculoSelecionado,
    super.funcionarioSelecionado,
  });

  @override
  List<Object?> get props => [
        clienteSelecionado,
        veiculoSelecionado,
        funcionarioSelecionado,
      ];
}

final class OrdensServicoSalvo extends OrdensServicoState {
  const OrdensServicoSalvo();

  @override
  List<Object?> get props => [];
}
