// Arquivo placeholder para o BLoC de veículos

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

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
      await Future.delayed(const Duration(seconds: 2));
      emit(const VeiculosLoaded());
    } catch (e) {}
  }
}
