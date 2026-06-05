import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:torpheus/data/models/endereco_model.dart';

import '../../../../data/models/cliente_model.dart';
import '../../../../domain/controller/permissao_controller.dart';
import '../../../../domain/repositories/remote/eapi_remote_repository.dart';

part 'cliente_event.dart';

part 'cliente_state.dart';

class ClienteBloc extends Bloc<ClienteEvent, ClienteState> {
  late final EapiRemoteRepository _eapiRemoteRepository;
  late final PermissaoController _permissaoController;

  ClienteBloc(
    this._eapiRemoteRepository,
    this._permissaoController,
  ) : super(const ClienteInitial()) {
    on<ClientesLoad>(_onClientesLoad);
    on<ClienteSelecionar>(_onClienteSelecionar);
    on<ClienteCadastrar>(_onClienteCadastrar);
    on<ClienteAtualizar>(_onClienteAtualizar);
  }

  Future<void> _onClientesLoad(
    ClientesLoad event,
    Emitter<ClienteState> emit,
  ) async {
    emit(const ClienteLoading());
    try {
      bool hasCriarCliente = false;

      final clientes = await _eapiRemoteRepository.getClientes();

      hasCriarCliente = _permissaoController.podeCriarCliente;

      emit(
        ClienteLoaded(
          clientes: clientes,
          hasCriarCliente: hasCriarCliente,
        ),
      );
    } catch (e) {
      emit(ClienteError('Não foi possível carregar os clientes\n$e'));
    }
  }

  void _onClienteSelecionar(
    ClienteSelecionar event,
    Emitter<ClienteState> emit,
  ) {
    emit(
      ClienteSelecionado(
        clientes: state.clientes,
        clienteSelecionado: event.cliente,
      ),
    );
  }

  void _onClienteCadastrar(
    ClienteCadastrar event,
    Emitter<ClienteState> emit,
  ) {
    emit(const ClienteCadastrando());
  }

  void _onClienteAtualizar(
    ClienteAtualizar event,
    Emitter<ClienteState> emit,
  ) {
    emit(ClienteAtualizando(clienteSelecionado: event.cliente));
  }
}
