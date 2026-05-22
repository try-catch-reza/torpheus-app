import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'mecanicos_event.dart';

part 'mecanicos_state.dart';

class MecanicosBloc extends Bloc<MecanicosEvent, MecanicosState> {
  MecanicosBloc() : super(const MecanicosInitial()) {
    on<MecanicosLoad>(_onMecanicosLoad);
  }

  Future<void> _onMecanicosLoad(
    MecanicosLoad event,
    Emitter<MecanicosState> emit,
  ) async {
    emit(const MecanicosLoading());
    try {
      await Future.delayed(const Duration(seconds: 2));
      emit(const MecanicosLoaded());
    } catch (e) {}
  }
}
