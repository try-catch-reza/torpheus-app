import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'relatorios_event.dart';
part 'relatorios_state.dart';

class RelatoriosBloc extends Bloc<RelatoriosEvent, RelatoriosState> {
  RelatoriosBloc() : super(const RelatoriosInitial()) {
    on<RelatoriosLoad>(_onRelatoriosLoad);
  }

  Future<void> _onRelatoriosLoad(
    RelatoriosLoad event,
    Emitter<RelatoriosState> emit,
  ) async {
    emit(const RelatoriosLoading());
    try {
      // Simulação de carregamento de relatórios
      await Future.delayed(const Duration(seconds: 2));
      emit(const RelatoriosLoaded());
    } catch (e) {
      // Em caso de erro, emitir estado de falha se necessário
      // emit(RelatoriosError(message: e.toString()));
    }
  }
}
