import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:torpheus/data/models/cliente_detalhe_model.dart';
import 'package:torpheus/data/models/cliente_model.dart';

import '../../../../data/models/cliente_estatisticas.dart';

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
      await Future.delayed(const Duration(seconds: 1));

      const detalhe = ClienteDetalheModel(
        id: '1',
        nome: 'Rafael Mendes',
        cpf: '012.345.678-90',
        telefone: '(49) 99111-2233',
        email: 'rafael@email.com',
        status: 'Ativo',
        veiculos: [],
        estatisticas: ClienteEstatisticas(
          osConcluidas: 10,
          osDoCliente: 10,
          veiculosAtendidos: 10,
        ),
      );

      emit(const ClienteDetalheLoaded(detalhe: detalhe));
    } catch (e) {
      emit(
        const ClienteDetalheError(
          'Não foi possível carregar o detalhe do cliente',
        ),
      );
    }
  }
}
