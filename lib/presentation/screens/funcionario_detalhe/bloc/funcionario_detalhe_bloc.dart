import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:torpheus/data/models/funcionario_model.dart';

part 'funcionario_detalhe_event.dart';

part 'funcionario_detalhe_state.dart';

class FuncionarioDetalheBloc
    extends Bloc<FuncionarioDetalheEvent, FuncionarioDetalheState> {
  FuncionarioDetalheBloc() : super(const FuncionarioDetalheInitial()) {
    on<FuncionarioDetalheLoad>(_onFuncionarioDetalheLoad);
  }

  Future<void> _onFuncionarioDetalheLoad(
    FuncionarioDetalheLoad event,
    Emitter<FuncionarioDetalheState> emit,
  ) async {
    emit(const FuncionarioDetalheLoading());
    try {
      emit(FuncionarioDetalheLoaded(funcionario: event.funcionario));
    } catch (e) {
      emit(
        const FuncionarioDetalheError(
          'Não foi possível carregar o detalhe do funcionário',
        ),
      );
    }
  }
}

