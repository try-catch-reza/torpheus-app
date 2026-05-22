import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'cliente_event.dart';

part 'cliente_state.dart';

class ClienteBloc extends Bloc<ClienteEvent, ClienteState> {
  ClienteBloc() : super(const ClienteInitial()) {
    on<ClientesLoad>(_onClientesLoad);
  }

  Future<void> _onClientesLoad(
    ClientesLoad event,
    Emitter<ClienteState> emit,
  ) async {
    emit(const ClienteLoading());
    try {
      // Simulação de carregamento de clientes
      await Future.delayed(const Duration(seconds: 2));
      emit(const ClienteLoaded());
    } catch (e) {
      // Em caso de erro, você pode emitir um estado de falha
      // emit(ClienteError(message: e.toString()));
    }
  }
}
