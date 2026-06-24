part of 'cadastrar_cliente_bloc.dart';

sealed class CadastrarClienteState extends Equatable {
  const CadastrarClienteState({
    this.endereco = const EnderecoModel(),
    this.documentoTipo = DocumentoTipo.cpf,
    this.clienteEditar,
    this.clienteId = '',
    this.isEdit = false,
    this.hasAtualizarCliente = false,
  });

  final EnderecoModel endereco;
  final DocumentoTipo documentoTipo;
  final ClienteModel? clienteEditar;
  final bool isEdit;
  final String clienteId;

  final bool hasAtualizarCliente;

  @override
  List<Object?> get props => [
        endereco,
        documentoTipo,
        clienteEditar,
        isEdit,
        clienteId,
        hasAtualizarCliente,
      ];
}

final class CadastrarClienteInitial extends CadastrarClienteState {
  const CadastrarClienteInitial();

  @override
  List<Object?> get props => [];
}

final class CadastrarClienteLoading extends CadastrarClienteState {
  const CadastrarClienteLoading({
    super.clienteEditar,
    super.clienteId,
    super.isEdit,
  });

  @override
  List<Object?> get props => [clienteEditar, clienteId, isEdit];
}

final class CadastrarClienteLoaded extends CadastrarClienteState {
  const CadastrarClienteLoaded({
    required super.endereco,
    required super.documentoTipo,
    super.clienteEditar,
    super.clienteId,
    super.isEdit,
    super.hasAtualizarCliente,
  });

  @override
  List<Object?> get props => [
        endereco,
        documentoTipo,
        clienteEditar,
        hasAtualizarCliente,
      ];
}

final class CadastrarClienteSuccess extends CadastrarClienteState {
  const CadastrarClienteSuccess();

  @override
  List<Object?> get props => [];
}

final class CadastrarClienteError extends CadastrarClienteState {
  const CadastrarClienteError({
    required this.message,
    required super.clienteId,
    required super.isEdit,
  });

  final String message;

  @override
  List<Object?> get props => [message];
}

final class CadastrarClienteSetandoCEP extends CadastrarClienteState {
  const CadastrarClienteSetandoCEP({
    super.clienteId,
    super.isEdit,
  });

  @override
  List<Object?> get props => [];
}

final class CadastrarClienteSetadoCEP extends CadastrarClienteState {
  const CadastrarClienteSetadoCEP({
    required super.endereco,
    required super.clienteId,
    required super.isEdit,
  });

  @override
  List<Object?> get props => [endereco, clienteId, isEdit];
}

final class CadastrarClienteEditando extends CadastrarClienteState {
  const CadastrarClienteEditando({
    required super.clienteEditar,
    required super.clienteId,
    required super.isEdit,
  });

  @override
  List<Object?> get props => [clienteEditar, clienteId, isEdit];
}

final class CadastrarClienteAtualizado extends CadastrarClienteState {
  const CadastrarClienteAtualizado();

  @override
  List<Object?> get props => [clienteEditar];
}
