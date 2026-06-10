import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:torpheus/data/models/veiculo_model.dart';

import '../../../../domain/controller/permissao_controller.dart';
import '../../../../domain/repositories/remote/eapi_remote_repository.dart';

part 'veiculo_detalhe_event.dart';

part 'veiculo_detalhe_state.dart';

class VeiculoDetalheBloc
    extends Bloc<VeiculoDetalheEvent, VeiculoDetalheState> {
  late final PermissaoController _permissaoController;
  late final EapiRemoteRepository _eapiRemoteRepository;

  VeiculoDetalheBloc(
    this._permissaoController,
    this._eapiRemoteRepository,
  ) : super(const VeiculoDetalheInitial()) {
    on<VeiculoDetalheLoad>(_onVeiculoDetalheLoad);
  }

  Future<void> _onVeiculoDetalheLoad(
    VeiculoDetalheLoad event,
    Emitter<VeiculoDetalheState> emit,
  ) async {
    emit(const VeiculoDetalheLoading());
    try {
      final hasEditarVeiculo = _permissaoController.podeAtualizarVeiculo;

      final veiculo = await _eapiRemoteRepository.getVeiculoById(
        event.veiculo?.id ?? '',
      );

      emit(
        VeiculoDetalheLoaded(
          veiculo: veiculo,
          hasEditarVeiculo: hasEditarVeiculo,
        ),
      );
    } catch (e) {
      emit(
        const VeiculoDetalheError(
          'Não foi possível carregar o detalhe do veículo',
        ),
      );
    }
  }
}
