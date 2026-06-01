part of 'cadastrar_veiculo_bloc.dart';

sealed class CadastrarVeiculoState extends Equatable {
  const CadastrarVeiculoState({
    this.veiculoEditar = const VeiculoModel(),
    this.veiculoId = '',
    this.isEdit = false,
    this.isAtivo = true,
  });

  final VeiculoModel veiculoEditar;
  final bool isEdit;
  final String veiculoId;
  final bool isAtivo;

  @override
  List<Object?> get props => [
        veiculoEditar,
        isEdit,
        veiculoId,
        isAtivo,
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
  });

  @override
  List<Object?> get props => [veiculoEditar, veiculoId, isEdit];
}

final class CadastrarVeiculoLoaded extends CadastrarVeiculoState {
  const CadastrarVeiculoLoaded({
    super.veiculoEditar,
    super.veiculoId,
    super.isEdit,
    super.isAtivo,
  });

  @override
  List<Object?> get props => [veiculoEditar, veiculoId, isEdit, isAtivo];
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

