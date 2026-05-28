part of 'cadastrar_cliente_bloc.dart';

sealed class CadastrarClienteState extends Equatable {
  const CadastrarClienteState({
    this.endereco = const EnderecoModel(),
    this.documentoTipo = DocumentoTipo.cpf,
  });

  final EnderecoModel endereco;
  final DocumentoTipo documentoTipo;

  @override
  List<Object?> get props => [endereco, documentoTipo];
}

final class CadastrarClienteInitial extends CadastrarClienteState {
  const CadastrarClienteInitial();

  @override
  List<Object?> get props => [];
}

final class CadastrarClienteLoading extends CadastrarClienteState {
  const CadastrarClienteLoading();

  @override
  List<Object?> get props => [];
}

final class CadastrarClienteLoaded extends CadastrarClienteState {
  const CadastrarClienteLoaded({
    required super.endereco,
    required super.documentoTipo,
  });

  @override
  List<Object?> get props => [endereco, documentoTipo];
}

final class CadastrarClienteSuccess extends CadastrarClienteState {
  const CadastrarClienteSuccess();

  @override
  List<Object?> get props => [];
}

final class CadastrarClienteError extends CadastrarClienteState {
  const CadastrarClienteError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

final class CadastrarClienteSetandoCEP extends CadastrarClienteState {
  const CadastrarClienteSetandoCEP();

  @override
  List<Object?> get props => [];
}

final class CadastrarClienteSetadoCEP extends CadastrarClienteState {
  const CadastrarClienteSetadoCEP({required super.endereco});

  @override
  List<Object?> get props => [endereco];
}
