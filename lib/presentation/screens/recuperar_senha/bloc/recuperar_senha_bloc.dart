import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'recuperar_senha_event.dart';

part 'recuperar_senha_state.dart';

class RecuperarSenhaBloc
    extends Bloc<RecuperarSenhaEvent, RecuperarSenhaState> {
  RecuperarSenhaBloc() : super(const RecuperarSenhaInitial()) {
    on<RecuperarSenhaLoad>(_onRecuperarSenhaLoad);
    on<RecuperarSenhaSolicitar>(_onRecuperarSenhaSolicitar);
  }

  void _onRecuperarSenhaLoad(
    RecuperarSenhaLoad event,
    Emitter<RecuperarSenhaState> emit,
  ) {
    emit(const RecuperarSenhaLoading());
    emit(const RecuperarSenhaLoaded());
  }

  FutureOr<void> _onRecuperarSenhaSolicitar(
    RecuperarSenhaSolicitar event,
    Emitter<RecuperarSenhaState> emit,
  ) async {
    emit(const RecuperarSenhaLoading());
    try {
      // TODO: integrar com serviço de autenticação / repositório
      await Future.delayed(const Duration(seconds: 1));

      // Simulação: se o e-mail contém "@" consideramos sucesso.
      if (event.email.contains('@')) {
        emit(const RecuperarSenhaLoaded());
      } else {
        emit(const RecuperarSenhaFailure(error: 'E-mail inválido.'));
      }
    } catch (e) {
      emit(RecuperarSenhaFailure(error: e.toString()));
    }
  }
}
