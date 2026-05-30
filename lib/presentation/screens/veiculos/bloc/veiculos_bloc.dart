
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:torpheus/data/models/veiculo_model.dart';

part 'veiculos_event.dart';

part 'veiculos_state.dart';

class VeiculosBloc extends Bloc<VeiculosEvent, VeiculosState> {
  VeiculosBloc() : super(const VeiculosInitial()) {
    on<VeiculosLoad>(_onVeiculosLoad);
  }

  Future<void> _onVeiculosLoad(
    VeiculosLoad event,
    Emitter<VeiculosState> emit,
  ) async {
    emit(const VeiculosLoading());
    try {
      final veiculos = [
        const VeiculoModel(
          placa: 'ABC-1234',
          modelo: 'Fiat Uno',
          ano: '2010',
          cor: 'Preto',
        ),
        const VeiculoModel(
          placa: 'DEF-5678',
          modelo: 'Volkswagen Gol',
          ano: '2015',
          cor: 'Branco',
        ),
      ];

      emit(VeiculosLoaded(veiculos: veiculos));
    } catch (e) {}
  }
}
