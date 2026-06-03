import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:torpheus/data/models/veiculo_model.dart';

import '../../../../data/datasources/remote/http_client.dart';

part 'veiculos_event.dart';

part 'veiculos_state.dart';

class VeiculosBloc extends Bloc<VeiculosEvent, VeiculosState> {
  VeiculosBloc() : super(const VeiculosInitial()) {
    on<VeiculosLoad>(_onVeiculosLoad);
    on<VeiculoSubmit>(_onVeiculoSubmit);
    on<VeiculoSetTipo>(_onVeiculoSetTipo);
    on<VeiculoSetMarca>(_onCadastrarVeiculoSetMarca);
    on<VeiculoSetCambio>(_onVeiculoSetCambio);
    on<VeiculoSetCombustivel>(_onVeiculoSetCombustivel);
  }

  Future<void> _onVeiculosLoad(
    VeiculosLoad event,
    Emitter<VeiculosState> emit,
  ) async {
    emit(const VeiculosLoading());
    try {
      final veiculos = [
        const VeiculoModel(
          placa: 'ABC-1234',
          modelo: 'Fiat Uno',
          ano: '2010',
          tipo: 'Hatch',
          marca: 'Fiat',
          cambio: 'Manual',
          combustivel: 'Gasolina',
          motor: '1.0',
        ),
        const VeiculoModel(
          placa: 'DEF-5678',
          modelo: 'Volkswagen Gol',
          ano: '2015',
          tipo: 'Hatch',
          marca: 'Volkswagen',
          cambio: 'Manual',
          combustivel: 'Flex',
          motor: '1.6',
        ),
      ];

      emit(VeiculosLoaded(veiculos: veiculos));
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

      print('Veiculo: $veiculo');

      // await _eapiRemoteRepository.cadastrarVeiculo(event.veiculo);
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
      ),
    );
  }
}
