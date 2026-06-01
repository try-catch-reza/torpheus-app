import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../data/models/mecanico_model.dart';
import '../../../../domain/repositories/remote/eapi_remote_repository.dart';

part 'funcionario_event.dart';
part 'funcionario_state.dart';


class FuncionarioBloc extends Bloc<FuncionarioEvent, FuncionarioState> {
  late final EapiRemoteRepository _eapiRemoteRepository;

  FuncionarioBloc(this._eapiRemoteRepository) : super(const FuncionarioInitial()) {
    on<FuncionarioLoad>(_onFuncionarioLoad);
    on<FuncionarioCadastrar>(_onFuncionarioCadastrar);
  }

  Future<void> _onFuncionarioLoad(
    FuncionarioLoad event,
    Emitter<FuncionarioState> emit,
  ) async {
    emit(const FuncionarioLoading());
    try {

      // final funcionarios = await _eapiRemoteRepository.getFuncionarios();

      final funcionarios = [
        FuncionarioModel(
          telefone: '(11) 99999-9999',
          isActive: true,
          documento: '123.456.789-00',
          nome: 'João Silva',
          funcao: 'Mecânico',
          hiredAt: DateTime.now(),
        ),
      ];

      emit(FuncionarioLoaded(funcionarios: funcionarios));
    } catch (e) {
      emit(FuncionarioError(e.toString()));
    }
  }

  void _onFuncionarioCadastrar(
    FuncionarioCadastrar event,
    Emitter<FuncionarioState> emit,
  ) {
    emit(const FuncionarioCadastrando());
  }
}
