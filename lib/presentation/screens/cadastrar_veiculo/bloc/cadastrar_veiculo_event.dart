part of 'cadastrar_veiculo_bloc.dart';

sealed class CadastrarVeiculoEvent extends Equatable {
  const CadastrarVeiculoEvent();

  @override
  List<Object?> get props => [];
}

final class CadastrarVeiculoLoad extends CadastrarVeiculoEvent {
  const CadastrarVeiculoLoad({required this.isEdit, required this.veiculoId});

  final bool isEdit;
  final String veiculoId;

  @override
  List<Object?> get props => [isEdit, veiculoId];
}

final class CadastrarVeiculoSubmit extends CadastrarVeiculoEvent {
  const CadastrarVeiculoSubmit({required this.veiculo});

  final VeiculoModel veiculo;

  @override
  List<Object?> get props => [veiculo];
}

final class CadastrarVeiculoUpdate extends CadastrarVeiculoEvent {
  const CadastrarVeiculoUpdate({required this.veiculo});

  final VeiculoModel veiculo;

  @override
  List<Object?> get props => [veiculo];
}

final class CadastrarVeiculoSetAtivo extends CadastrarVeiculoEvent {
  const CadastrarVeiculoSetAtivo(this.isAtivo);

  final bool isAtivo;

  @override
  List<Object?> get props => [isAtivo];
}

