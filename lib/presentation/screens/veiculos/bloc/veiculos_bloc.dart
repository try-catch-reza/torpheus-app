import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:torpheus/core/constants/enum/cambio_veiculo.dart';
import 'package:torpheus/core/constants/enum/combustivel_veiculo.dart';
import 'package:torpheus/core/constants/enum/marca_veiculo.dart';
import 'package:torpheus/core/constants/enum/tipo_veiculo.dart';
import 'package:torpheus/data/models/veiculo_model.dart';

import '../../../../data/datasources/remote/http_client.dart';
import '../../../../domain/controller/permissao_controller.dart';
import '../../../../domain/repositories/remote/eapi_remote_repository.dart';

part 'veiculos_event.dart';

part 'veiculos_state.dart';

class VeiculosBloc extends Bloc<VeiculosEvent, VeiculosState> {
  late final EapiRemoteRepository _eapiRemoteRepository;
  late final PermissaoController _permissaoController;

  VeiculosBloc(
    this._eapiRemoteRepository,
    this._permissaoController,
  ) : super(const VeiculosInitial()) {
    on<VeiculosLoad>(_onVeiculosLoad);
    on<VeiculoSubmit>(_onVeiculoSubmit);
    on<VeiculoSetTipo>(_onVeiculoSetTipo);
    on<VeiculoSetMarca>(_onCadastrarVeiculoSetMarca);
    on<VeiculoSetCambio>(_onVeiculoSetCambio);
    on<VeiculoSetCombustivel>(_onVeiculoSetCombustivel);
    on<VeiculoSearch>(_onVeiculoSearch);
    on<VeiculoUpdate>(_onVeiculoUpdate);
    on<VeiculoSetUpdate>(_onVeiculoSetUpdate);
    on<VeiculoSetAtivo>(_onVeiculoSetAtivo);
  }

  Future<void> _onVeiculosLoad(
    VeiculosLoad event,
    Emitter<VeiculosState> emit,
  ) async {
    emit(const VeiculosLoading());
    try {
      final veiculos = await _eapiRemoteRepository.getVeiculos();
      final hasCriarVeiculo = _permissaoController.podeCriarVeiculo;
      final hasEditarVeiculo = _permissaoController.podeAtualizarVeiculo;

      emit(
        VeiculosLoaded(
          veiculos: veiculos,
          hasCriarVeiculo: hasCriarVeiculo,
          veiculosFiltered: veiculos,
          hasEditarVeiculo: hasEditarVeiculo,
        ),
      );
    } catch (e) {
      emit(VeiculosError('Não foi possível carregar os veículos\n$e'));
    }
  }

  Future<void> _onVeiculoSubmit(
    VeiculoSubmit event,
    Emitter<VeiculosState> emit,
  ) async {
    emit(
      VeiculosSalvando(
        veiculos: state.veiculos,
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

      await _eapiRemoteRepository.cadastrarVeiculo(veiculo);
      emit(const VeiculoSuccess());
    } on HttpRequestException catch (e) {
      emit(VeiculosError(e.title));
    } catch (e) {
      emit(VeiculosError('Não foi possível cadastrar o veículo.\n$e'));
    }
  }

  void _onVeiculoSetTipo(
    VeiculoSetTipo event,
    Emitter<VeiculosState> emit,
  ) {
    emit(
      VeiculosLoaded(
        tipo: event.tipo,
        cambio: state.cambio,
        combustivel: state.combustivel,
        marca: state.marca,
        veiculos: state.veiculos,
        veiculosFiltered: state.veiculosFiltered,
      ),
    );
  }

  void _onCadastrarVeiculoSetMarca(
    VeiculoSetMarca event,
    Emitter<VeiculosState> emit,
  ) {
    emit(
      VeiculosLoaded(
        marca: event.marca,
        combustivel: state.combustivel,
        cambio: state.cambio,
        tipo: state.tipo,
        veiculos: state.veiculos,
        veiculosFiltered: state.veiculosFiltered,
      ),
    );
  }

  void _onVeiculoSetCambio(
    VeiculoSetCambio event,
    Emitter<VeiculosState> emit,
  ) {
    emit(
      VeiculosLoaded(
        cambio: event.cambio,
        combustivel: state.combustivel,
        marca: state.marca,
        tipo: state.tipo,
        veiculos: state.veiculos,
        veiculosFiltered: state.veiculosFiltered,
      ),
    );
  }

  void _onVeiculoSetCombustivel(
    VeiculoSetCombustivel event,
    Emitter<VeiculosState> emit,
  ) {
    emit(
      VeiculosLoaded(
        veiculos: state.veiculos,
        cambio: state.cambio,
        combustivel: event.combustivel,
        marca: state.marca,
        tipo: state.tipo,
        veiculosFiltered: state.veiculosFiltered,
      ),
    );
  }

  void _onVeiculoSearch(
    VeiculoSearch event,
    Emitter<VeiculosState> emit,
  ) {
    List<VeiculoModel> veiculosFiltered = [];

    if (event.search.isNotEmpty) {
      veiculosFiltered = state.veiculos.where(
        (veiculo) {
          return veiculo.placa!.contains(event.search.toUpperCase().trim());
        },
      ).toList();
    } else {
      veiculosFiltered = state.veiculos;
    }

    emit(
      VeiculosLoaded(
        veiculos: state.veiculos,
        cambio: state.cambio,
        combustivel: state.combustivel,
        marca: state.marca,
        tipo: state.tipo,
        veiculosFiltered: veiculosFiltered,
        search: event.search,
        hasCriarVeiculo: state.hasCriarVeiculo,
      ),
    );
  }

  FutureOr<void> _onVeiculoUpdate(
    VeiculoUpdate event,
    Emitter<VeiculosState> emit,
  ) async {
    try {
      emit(
        VeiculosAtualizando(
          veiculos: state.veiculos,
          cambio: state.cambio,
          combustivel: state.combustivel,
          marca: state.marca,
          tipo: state.tipo,
          veiculoEditar: state.veiculoEditar,
        ),
      );

      final veiculo = VeiculoModel(
        id: event.id,
        ano: event.ano,
        motor: event.motor,
        modelo: event.modelo,
        placa: event.placa,
        tipo: state.tipo,
        cambio: state.cambio,
        combustivel: state.combustivel,
        marca: state.marca,
        isActive: state.veiculoEditar?.isActive,
      );

      await _eapiRemoteRepository.updateVeiculo(veiculo);
      emit(const VeiculoAtualizado());
    } on HttpRequestException catch (e) {
      emit(VeiculosError(e.title));
    } catch (e) {
      emit(VeiculosError('Não foi possível atualizar o veículo.\n$e'));
    }
  }

  void _onVeiculoSetUpdate(
    VeiculoSetUpdate event,
    Emitter<VeiculosState> emit,
  ) {
    emit(
      VeiculosLoaded(
        veiculos: state.veiculos,
        cambio: event.veiculo.cambio,
        combustivel: event.veiculo.combustivel,
        marca: event.veiculo.marca,
        tipo: event.veiculo.tipo,
        veiculosFiltered: state.veiculosFiltered,
        hasEditarVeiculo: state.hasCriarVeiculo,
        hasCriarVeiculo: state.hasCriarVeiculo,
        veiculoEditar: event.veiculo,
      ),
    );
  }

  void _onVeiculoSetAtivo(
    VeiculoSetAtivo event,
    Emitter<VeiculosState> emit,
  ) {
    final veiculo = state.veiculoEditar!.copyWith(
      isActive: state.veiculoEditar?.isActive == true ? false : true,
    );

    emit(
      VeiculosLoaded(
        veiculos: state.veiculos,
        cambio: state.cambio,
        combustivel: state.combustivel,
        marca: state.marca,
        tipo: state.tipo,
        veiculosFiltered: state.veiculosFiltered,
        hasEditarVeiculo: state.hasCriarVeiculo,
        hasCriarVeiculo: state.hasCriarVeiculo,
        veiculoEditar: veiculo,
      ),
    );
  }
}
