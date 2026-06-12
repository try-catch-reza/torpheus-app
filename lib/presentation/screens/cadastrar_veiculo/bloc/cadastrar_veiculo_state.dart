part of 'cadastrar_veiculo_bloc.dart';

sealed class CadastrarVeiculoState extends Equatable {
  const CadastrarVeiculoState({
    this.veiculoEditar,
    this.veiculoId = '',
    this.isEdit = false,
    this.isAtivo = true,
    this.cambio,
    this.marca,
    this.combustivel,
    this.tipo,
    this.hasAtualizarVeiculo = false,
  });

  final VeiculoModel? veiculoEditar;
  final bool isEdit;
  final String veiculoId;
  final bool isAtivo;

  final CambioVeiculo? cambio;
  final MarcaVeiculo? marca;
  final CombustivelVeiculo? combustivel;
  final TipoVeiculo? tipo;

  final bool hasAtualizarVeiculo;

  @override
  List<Object?> get props => [
        veiculoEditar,
        isEdit,
        veiculoId,
        isAtivo,
        cambio,
        marca,
        combustivel,
        tipo,
        hasAtualizarVeiculo,
      ];
}

final class CadastrarVeiculoInitial extends CadastrarVeiculoState {
  const CadastrarVeiculoInitial();

  @override
  List<Object?> get props => [];
}

final class CadastrarVeiculoLoading extends CadastrarVeiculoState {
  const CadastrarVeiculoLoading({
    super.veiculoEditar,
    super.veiculoId,
    super.isEdit,
    super.cambio,
    super.marca,
    super.combustivel,
    super.tipo,
  });

  @override
  List<Object?> get props => [
        veiculoEditar,
        veiculoId,
        isEdit,
        cambio,
        marca,
        combustivel,
        tipo,
      ];
}

final class CadastrarVeiculoLoaded extends CadastrarVeiculoState {
  const CadastrarVeiculoLoaded({
    super.veiculoEditar,
    super.veiculoId,
    super.isEdit,
    super.isAtivo,
    super.cambio,
    super.marca,
    super.combustivel,
    super.tipo,
    super.hasAtualizarVeiculo,
  });

  @override
  List<Object?> get props => [
        veiculoEditar,
        veiculoId,
        isEdit,
        isAtivo,
        cambio,
        marca,
        combustivel,
        tipo,
        hasAtualizarVeiculo,
      ];
}

final class CadastrarVeiculoSuccess extends CadastrarVeiculoState {
  const CadastrarVeiculoSuccess();

  @override
  List<Object?> get props => [];
}

final class CadastrarVeiculoError extends CadastrarVeiculoState {
  const CadastrarVeiculoError({
    required this.message,
    required super.veiculoId,
    required super.isEdit,
  });

  final String message;

  @override
  List<Object?> get props => [message, veiculoId, isEdit];
}

final class CadastrarVeiculoEditando extends CadastrarVeiculoState {
  const CadastrarVeiculoEditando({
    required super.veiculoEditar,
    required super.veiculoId,
    required super.isEdit,
  });

  @override
  List<Object?> get props => [veiculoEditar, veiculoId, isEdit];
}

final class CadastrarVeiculoAtualizado extends CadastrarVeiculoState {
  const CadastrarVeiculoAtualizado();

  @override
  List<Object?> get props => [];
}
