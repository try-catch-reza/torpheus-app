import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'ordens_servico_event.dart';
part 'ordens_servico_state.dart';

class OrdensServicoBloc extends Bloc<OrdensServicoEvent, OrdensServicoState> {
  OrdensServicoBloc() : super(const OrdensServicoInitial()) {
    on<OrdensServicoLoad>(_onOrdensServicoLoad);
  }

  Future<void> _onOrdensServicoLoad(
    OrdensServicoLoad event,
    Emitter<OrdensServicoState> emit,
  ) async {
    emit(const OrdensServicoLoading());
    try {
      // Simulação de carregamento de ordens de serviço
      await Future.delayed(const Duration(seconds: 2));
      emit(const OrdensServicoLoaded());
    } catch (e) {
      // Em caso de erro, emitir estado de falha se necessário
      // emit(OrdensServicoError(message: e.toString()));
    }
  }
}
