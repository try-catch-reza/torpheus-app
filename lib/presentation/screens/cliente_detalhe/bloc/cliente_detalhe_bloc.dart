import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:torpheus/data/models/cliente_model.dart';

part 'cliente_detalhe_event.dart';

part 'cliente_detalhe_state.dart';

class ClienteDetalheBloc
    extends Bloc<ClienteDetalheEvent, ClienteDetalheState> {
  ClienteDetalheBloc() : super(const ClienteDetalheInitial()) {
    on<ClienteDetalheLoad>(_onClienteDetalheLoad);
  }

  Future<void> _onClienteDetalheLoad(
    ClienteDetalheLoad event,
    Emitter<ClienteDetalheState> emit,
  ) async {
    emit(const ClienteDetalheLoading());
    try {
      emit(ClienteDetalheLoaded(cliente: event.cliente));
    } catch (e) {
      emit(
        const ClienteDetalheError(
          'Não foi possível carregar o detalhe do cliente',
        ),
      );
    }
  }
}
