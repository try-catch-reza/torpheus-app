import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:torpheus/data/models/cliente_model.dart';

import '../../../../domain/controller/permissao_controller.dart';

part 'cliente_detalhe_event.dart';

part 'cliente_detalhe_state.dart';

class ClienteDetalheBloc
    extends Bloc<ClienteDetalheEvent, ClienteDetalheState> {
  late final PermissaoController _permissaoController;

  ClienteDetalheBloc(
    this._permissaoController,
  ) : super(const ClienteDetalheInitial()) {
    on<ClienteDetalheLoad>(_onClienteDetalheLoad);
  }

  Future<void> _onClienteDetalheLoad(
    ClienteDetalheLoad event,
    Emitter<ClienteDetalheState> emit,
  ) async {
    emit(const ClienteDetalheLoading());
    try {
      final hasAtualizarCliente = _permissaoController.podeAtualizarCliente;

      emit(
        ClienteDetalheLoaded(
          cliente: event.cliente,
          hasAtualizarCliente: hasAtualizarCliente,
        ),
      );
    } catch (e) {
      emit(
        const ClienteDetalheError(
          'Não foi possível carregar o detalhe do cliente',
        ),
      );
    }
  }
}
