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
  const CadastrarVeiculoSubmit({
    required this.placa,
    required this.modelo,
    required this.motor,
    required this.ano,
  });

  final String placa;
  final String modelo;
  final String motor;
  final String ano;

  @override
  List<Object?> get props => [placa, modelo, motor, ano];
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

final class CadastrarVeiculoSetTipo extends CadastrarVeiculoEvent {
  const CadastrarVeiculoSetTipo(this.tipo);

  final String tipo;

  @override
  List<Object?> get props => [tipo];
}

final class CadastrarVeiculoSetMarca extends CadastrarVeiculoEvent {
  const CadastrarVeiculoSetMarca(this.marca);

  final String marca;

  @override
  List<Object?> get props => [marca];
}

final class CadastrarVeiculoSetCambio extends CadastrarVeiculoEvent {
  const CadastrarVeiculoSetCambio(this.cambio);

  final String cambio;

  @override
  List<Object?> get props => [cambio];
}

final class CadastrarVeiculoSetCombustivel extends CadastrarVeiculoEvent {
  const CadastrarVeiculoSetCombustivel(this.combustivel);

  final String combustivel;

  @override
  List<Object?> get props => [combustivel];
}

final class CadastrarVeiculoLimparCampos extends CadastrarVeiculoEvent {
  const CadastrarVeiculoLimparCampos();

  @override
  List<Object?> get props => [];
}

