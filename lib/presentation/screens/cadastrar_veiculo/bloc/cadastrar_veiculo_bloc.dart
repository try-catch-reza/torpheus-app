import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:torpheus/data/models/veiculo_model.dart';

import '../../../../data/datasources/remote/http_client.dart';
import '../../../../domain/repositories/remote/eapi_remote_repository.dart';

part 'cadastrar_veiculo_event.dart';

part 'cadastrar_veiculo_state.dart';

class CadastrarVeiculoBloc
    extends Bloc<CadastrarVeiculoEvent, CadastrarVeiculoState> {
  late final EapiRemoteRepository _eapiRemoteRepository;

  CadastrarVeiculoBloc(
    this._eapiRemoteRepository,
  ) : super(const CadastrarVeiculoInitial()) {
    on<CadastrarVeiculoLoad>(_onCadastrarVeiculoLoad);
    on<CadastrarVeiculoSubmit>(_onCadastrarVeiculoSubmit);
    on<CadastrarVeiculoUpdate>(_onCadastrarVeiculoUpdate);
    on<CadastrarVeiculoSetAtivo>(_onCadastrarVeiculoSetAtivo);
    on<CadastrarVeiculoSetTipo>(_onCadastrarVeiculoSetTipo);
    on<CadastrarVeiculoSetMarca>(_onCadastrarVeiculoSetMarca);
    on<CadastrarVeiculoSetCambio>(_onCadastrarVeiculoSetCambio);
    on<CadastrarVeiculoSetCombustivel>(_onCadastrarVeiculoSetCombustivel);
    on<CadastrarVeiculoLimparCampos>(_onCadastrarVeiculoLimparCampos);
  }

  Future<void> _onCadastrarVeiculoLoad(
    CadastrarVeiculoLoad event,
    Emitter<CadastrarVeiculoState> emit,
  ) async {
    if (event.isEdit) {
      // final veiculo = await _eapiRemoteRepository.getVeiculoById(
      //   event.veiculoId,
      // );

      // emit(
      //   CadastrarVeiculoEditando(
      //     veiculoEditar: veiculo,
      //     isEdit: event.isEdit,
      //     veiculoId: event.veiculoId,
      //   ),
      // );
      //
      // emit(
      //   CadastrarVeiculoLoaded(
      //     veiculoEditar: veiculo,
      //     veiculoId: event.veiculoId,
      //     isEdit: event.isEdit,
      //   ),
      // );

      return;
    }

    emit(
      CadastrarVeiculoLoaded(
        veiculoEditar: state.veiculoEditar,
      ),
    );
  }

  Future<void> _onCadastrarVeiculoSubmit(
    CadastrarVeiculoSubmit event,
    Emitter<CadastrarVeiculoState> emit,
  ) async {
    emit(
      CadastrarVeiculoLoading(
        cambio: state.cambio,
        combustivel: state.combustivel,
        marca: state.marca,
        tipo: state.tipo,
      ),
    );
    try {
      final veiculo = VeiculoModel(
        cambio: state.cambio,
        combustivel: state.combustivel,
        marca: state.marca,
        tipo: state.tipo,
        modelo: event.modelo,
        placa: event.placa,
        ano: event.ano,
        motor: event.motor,
      );

      // await _eapiRemoteRepository.cadastrarVeiculo(event.veiculo);
      emit(const CadastrarVeiculoSuccess());
    } on HttpRequestException catch (e) {
      emit(
        CadastrarVeiculoError(
          message: e.title,
          isEdit: state.isEdit,
          veiculoId: state.veiculoId,
        ),
      );
    } catch (e) {
      emit(
        CadastrarVeiculoError(
          message: 'Não foi possível cadastrar o veículo.\n$e',
          veiculoId: state.veiculoId,
          isEdit: state.isEdit,
        ),
      );
    }
  }

  Future<void> _onCadastrarVeiculoUpdate(
    CadastrarVeiculoUpdate event,
    Emitter<CadastrarVeiculoState> emit,
  ) async {
    emit(
      CadastrarVeiculoLoading(
        veiculoId: state.veiculoId,
        isEdit: state.isEdit,
        veiculoEditar: state.veiculoEditar,
      ),
    );

    try {
      // await _eapiRemoteRepository.updateVeiculo(event.veiculo, state.veiculoId);
      emit(const CadastrarVeiculoAtualizado());
    } on HttpRequestException catch (e) {
      emit(
        CadastrarVeiculoError(
          message: e.title,
          isEdit: state.isEdit,
          veiculoId: state.veiculoId,
        ),
      );
    } catch (e) {
      emit(
        CadastrarVeiculoError(
          message: 'Não foi possível atualizar o veículo.\n$e',
          veiculoId: state.veiculoId,
          isEdit: state.isEdit,
        ),
      );
    }
  }

  void _onCadastrarVeiculoSetAtivo(
    CadastrarVeiculoSetAtivo event,
    Emitter<CadastrarVeiculoState> emit,
  ) {
    emit(
      CadastrarVeiculoLoaded(
        veiculoEditar: state.veiculoEditar,
        isEdit: state.isEdit,
        veiculoId: state.veiculoId,
        isAtivo: event.isAtivo,
      ),
    );
  }

  void _onCadastrarVeiculoSetTipo(
    CadastrarVeiculoSetTipo event,
    Emitter<CadastrarVeiculoState> emit,
  ) {
    emit(
      CadastrarVeiculoLoaded(
        veiculoEditar: state.veiculoEditar,
        isEdit: state.isEdit,
        veiculoId: state.veiculoId,
        tipo: event.tipo,
        isAtivo: state.isAtivo,
        cambio: state.cambio,
        combustivel: state.combustivel,
        marca: state.marca,
      ),
    );
  }

  void _onCadastrarVeiculoSetMarca(
    CadastrarVeiculoSetMarca event,
    Emitter<CadastrarVeiculoState> emit,
  ) {
    emit(
      CadastrarVeiculoLoaded(
        veiculoEditar: state.veiculoEditar,
        isEdit: state.isEdit,
        veiculoId: state.veiculoId,
        marca: event.marca,
        combustivel: state.combustivel,
        cambio: state.cambio,
        tipo: state.tipo,
      ),
    );
  }

  void _onCadastrarVeiculoSetCambio(
    CadastrarVeiculoSetCambio event,
    Emitter<CadastrarVeiculoState> emit,
  ) {
    emit(
      CadastrarVeiculoLoaded(
        veiculoEditar: state.veiculoEditar,
        isEdit: state.isEdit,
        veiculoId: state.veiculoId,
        cambio: event.cambio,
        combustivel: state.combustivel,
        marca: state.marca,
        tipo: state.tipo,
      ),
    );
  }

  void _onCadastrarVeiculoSetCombustivel(
    CadastrarVeiculoSetCombustivel event,
    Emitter<CadastrarVeiculoState> emit,
  ) {
    emit(
      CadastrarVeiculoLoaded(
        veiculoEditar: state.veiculoEditar,
        isEdit: state.isEdit,
        veiculoId: state.veiculoId,
        cambio: state.cambio,
        combustivel: event.combustivel,
        marca: state.marca,
        tipo: state.tipo,
      ),
    );
  }

  void _onCadastrarVeiculoLimparCampos(
    CadastrarVeiculoLimparCampos event,
    Emitter<CadastrarVeiculoState> emit,
  ) {
    emit(
      CadastrarVeiculoLoaded(
        veiculoEditar: state.veiculoEditar,
        isEdit: state.isEdit,
        veiculoId: state.veiculoId,
        cambio: '',
        combustivel: '',
        marca: '',
        tipo: '',
      ),
    );
  }
}
