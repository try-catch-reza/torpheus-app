import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:torpheus/core/constants/enum/documento_tipo.dart';
import 'package:torpheus/data/models/cliente_model.dart';
import 'package:torpheus/data/models/endereco_model.dart';

import '../../../../data/datasources/remote/http_client.dart';
import '../../../../domain/repositories/remote/eapi_remote_repository.dart';

part 'cadastrar_cliente_event.dart';

part 'cadastrar_cliente_state.dart';

class CadastrarClienteBloc
    extends Bloc<CadastrarClienteEvent, CadastrarClienteState> {
  late final EapiRemoteRepository _eapiRemoteRepository;

  CadastrarClienteBloc(
    this._eapiRemoteRepository,
  ) : super(const CadastrarClienteInitial()) {
    on<CadastrarClienteLoad>(_onCadastrarClienteLoad);
    on<CadastrarClienteSubmit>(_onCadastrarClienteSubmit);
    on<CadastrarClienteSetCEP>(_onCadastrarClienteSetCEP);
    on<CadastrarClienteSelecionarDocumento>(
      _onCadastrarClienteSelecionarDocumento,
    );
    on<CadastrarClienteUpdate>(_onCadastrarClienteUpdate);
    on<CadastrarClienteSetAtivo>(_onCadastrarClienteSetAtivo);
  }

  Future<void> _onCadastrarClienteLoad(
    CadastrarClienteLoad event,
    Emitter<CadastrarClienteState> emit,
  ) async {
    if (event.isEdit) {
      final cliente = await _eapiRemoteRepository.getClienteById(
        event.clienteId,
      );

      emit(
        CadastrarClienteEditando(
          clienteEditar: cliente,
          isEdit: event.isEdit,
          clienteId: event.clienteId,
        ),
      );

      emit(
        CadastrarClienteLoaded(
          documentoTipo: cliente.documentoTipo!,
          endereco: state.endereco,
          clienteEditar: cliente,
          clienteId: event.clienteId,
          isEdit: event.isEdit,
        ),
      );

      return;
    }

    emit(
      CadastrarClienteLoaded(
        documentoTipo: state.documentoTipo,
        endereco: state.endereco,
      ),
    );
  }

  Future<void> _onCadastrarClienteSubmit(
    CadastrarClienteSubmit event,
    Emitter<CadastrarClienteState> emit,
  ) async {
    emit(const CadastrarClienteLoading());
    try {
      await _eapiRemoteRepository.cadastrarCliente(event.cliente);
      emit(const CadastrarClienteSuccess());
    } on HttpRequestException catch (e) {
      emit(
        CadastrarClienteError(
          message: e.title,
          isEdit: state.isEdit,
          clienteId: state.clienteId,
        ),
      );
    } catch (e) {
      emit(
        CadastrarClienteError(
          message: 'Não foi possível cadastrar o cliente.\n$e',
          clienteId: state.clienteId,
          isEdit: state.isEdit,
        ),
      );
    }
  }

  Future<void> _onCadastrarClienteSetCEP(
    CadastrarClienteSetCEP event,
    Emitter<CadastrarClienteState> emit,
  ) async {
    emit(
      CadastrarClienteSetandoCEP(
        isEdit: state.isEdit,
        clienteId: state.clienteId,
      ),
    );

    try {
      final endereco = await _eapiRemoteRepository.buscarEnderecoViaCep(
        event.cep,
      );

      emit(
        CadastrarClienteSetadoCEP(
          endereco: endereco,
          isEdit: state.isEdit,
          clienteId: state.clienteId,
        ),
      );
    } on HttpRequestException catch (e) {
      emit(CadastrarClienteError(
        message: e.title,
        isEdit: state.isEdit,
        clienteId: state.clienteId,
      ));
    } catch (e) {
      emit(
        CadastrarClienteError(
          message: 'Não foi possível buscar o endereço\n$e',
          clienteId: state.clienteId,
          isEdit: state.isEdit,
        ),
      );
    }
  }

  void _onCadastrarClienteSelecionarDocumento(
    CadastrarClienteSelecionarDocumento event,
    Emitter<CadastrarClienteState> emit,
  ) {
    emit(
      CadastrarClienteLoaded(
        documentoTipo: event.documentoTipo,
        endereco: state.endereco,
        clienteEditar: state.clienteEditar,
      ),
    );
  }

  Future<void> _onCadastrarClienteUpdate(
    CadastrarClienteUpdate event,
    Emitter<CadastrarClienteState> emit,
  ) async {
    emit(
      CadastrarClienteLoading(
        clienteId: state.clienteId,
        isEdit: state.isEdit,
        clienteEditar: state.clienteEditar,
      ),
    );

    try {
      await _eapiRemoteRepository.updateCliente(event.cliente, state.clienteId);
      emit(const CadastrarClienteAtualizado());
    } on HttpRequestException catch (e) {
      emit(
        CadastrarClienteError(
          message: e.message,
          isEdit: state.isEdit,
          clienteId: state.clienteId,
        ),
      );
    } catch (e) {
      emit(
        CadastrarClienteError(
          message: 'Não foi possível cadastrar o cliente.\n$e',
          clienteId: state.clienteId,
          isEdit: state.isEdit,
        ),
      );
    }
  }

  void _onCadastrarClienteSetAtivo(
    CadastrarClienteSetAtivo event,
    Emitter<CadastrarClienteState> emit,
  ) {
    final clienteAtualizado = state.clienteEditar!.copyWith(
      isActive: event.isActive,
    );

    emit(
      CadastrarClienteLoaded(
        documentoTipo: state.documentoTipo,
        endereco: state.endereco,
        clienteEditar: clienteAtualizado,
        isEdit: state.isEdit,
        clienteId: state.clienteId,
      ),
    );
  }
}
