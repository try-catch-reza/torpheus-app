import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'cadastrar_cliente_event.dart';

part 'cadastrar_cliente_state.dart';

class CadastrarClienteBloc
    extends Bloc<CadastrarClienteEvent, CadastrarClienteState> {
  CadastrarClienteBloc() : super(const CadastrarClienteInitial()) {
    on<CadastrarClienteLoad>(_onCadastrarClienteLoad);
    on<CadastrarClienteSubmit>(_onCadastrarClienteSubmit);
  }

  void _onCadastrarClienteLoad(
    CadastrarClienteLoad event,
    Emitter<CadastrarClienteState> emit,
  ) {
    emit(const CadastrarClienteLoaded());
  }

  Future<void> _onCadastrarClienteSubmit(
    CadastrarClienteSubmit event,
    Emitter<CadastrarClienteState> emit,
  ) async {
    emit(const CadastrarClienteLoading());
    try {
      // Aqui você chamaria o repositório para cadastrar o cliente.
      // No padrão do projeto, usamos um mock/espera curta.
      await Future.delayed(const Duration(milliseconds: 800));

      emit(const CadastrarClienteSuccess());
    } catch (e) {
      emit(CadastrarClienteError('Não foi possível cadastrar o cliente.\n$e'));
    }
  }
}
