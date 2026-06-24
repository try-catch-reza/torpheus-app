part of 'painel_bloc.dart';

sealed class PainelState extends Equatable {
  const PainelState({
    this.image,
    this.email = '',
    this.nome = '',
    this.cargo = '',
    this.hasAccessUsuario = false,
    this.hasAccessFuncionario = false,
    this.hasAccessCliente = false,
    this.hasAccessVeiculo = false,
    this.hasAccessPerfis = false,
    this.hasAccessOrdem = false,
  });

  final File? image;
  final String nome;
  final String email;
  final String cargo;

  final bool hasAccessUsuario;
  final bool hasAccessFuncionario;
  final bool hasAccessCliente;
  final bool hasAccessVeiculo;
  final bool hasAccessPerfis;
  final bool hasAccessOrdem;

  @override
  List<Object?> get props => [
        image,
        nome,
        email,
        cargo,
        hasAccessUsuario,
        hasAccessFuncionario,
        hasAccessVeiculo,
        hasAccessCliente,
        hasAccessPerfis,
        hasAccessOrdem,
      ];
}

final class PainelInitial extends PainelState {
  const PainelInitial();

  @override
  List<Object?> get props => [];
}

final class PainelLoading extends PainelState {
  const PainelLoading();

  @override
  List<Object?> get props => [];
}

final class PainelLoaded extends PainelState {
  const PainelLoaded({
    required super.email,
    required super.nome,
    required super.cargo,
    required super.hasAccessUsuario,
    required super.hasAccessCliente,
    required super.hasAccessFuncionario,
    required super.hasAccessVeiculo,
    required super.hasAccessPerfis,
    required super.hasAccessOrdem,
  });

  @override
  List<Object?> get props => [
        email,
        nome,
        cargo,
        hasAccessUsuario,
        hasAccessFuncionario,
        hasAccessVeiculo,
        hasAccessCliente,
        hasAccessPerfis,
        hasAccessOrdem,
      ];
}

final class PainelFail extends PainelState {
  const PainelFail(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
