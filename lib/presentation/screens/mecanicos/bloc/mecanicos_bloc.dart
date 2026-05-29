import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/models/mecanico_model.dart';
import '../../../../domain/repositories/remote/eapi_remote_repository.dart';

part 'mecanicos_event.dart';

part 'mecanicos_state.dart';

class FuncionarioBloc extends Bloc<MecanicosEvent, MecanicosState> {
  late final EapiRemoteRepository _eapiRemoteRepository;

  FuncionarioBloc(this._eapiRemoteRepository) : super(const MecanicosInitial()) {
    on<MecanicosLoad>(_onMecanicosLoad);
    on<MecanicosCadastrar>(_onMecanicosCadastrar);
  }

  Future<void> _onMecanicosLoad(
    MecanicosLoad event,
    Emitter<MecanicosState> emit,
  ) async {
    emit(const MecanicosLoading());
    try {

      final funcionarios = await _eapiRemoteRepository.getFuncionarios();

      emit(MecanicosLoaded(funcionarios: funcionarios));
    } catch (e) {
      emit(MecanicosError(e.toString()));
    }
  }

  void _onMecanicosCadastrar(
    MecanicosCadastrar event,
    Emitter<MecanicosState> emit,
  ) {
    emit(const MecanicoCadastrando());
  }
}
