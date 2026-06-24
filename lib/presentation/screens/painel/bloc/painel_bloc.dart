import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/controller/permissao_controller.dart';
import '../../../../domain/repositories/preferenfeces/preferences_local_repository.dart';

part 'painel_event.dart';

part 'painel_state.dart';

class PainelBloc extends Bloc<PainelEvent, PainelState> {
  late final PreferencesLocalRepository _preferencesLocalRepository;
  late final PermissaoController _permissaoController;

  PainelBloc(
    this._preferencesLocalRepository,
    this._permissaoController,
  ) : super(const PainelInitial()) {
    on<PainelCarregar>(_onPainelLoad);
    on<PainelAbrirCamera>(_onPainelAbrirCamera);
    on<PainelAbrirGaleria>(_onPainelAbrirGaleria);
  }

  Future<void> _onPainelLoad(
    PainelCarregar event,
    Emitter<PainelState> emit,
  ) async {
    try {
      emit(const PainelLoading());
      final nome = _preferencesLocalRepository.getNome();
      final email = _preferencesLocalRepository.getEmail();
      final cargo = _preferencesLocalRepository.getCargo();

      final hasAccessUsuario = _permissaoController.podeLerUsuario;
      final hasAccessFuncionario = _permissaoController.podeLerFuncionario;
      final hasAccessCliente = _permissaoController.podeLerCliente;
      final hasAccessVeiculo = _permissaoController.podeLerVeiculo;
      final hasAccessPerfis = _permissaoController.podeLerRole;
      final hasAccessOrdem = _permissaoController.podeLerOS;

      emit(
        PainelLoaded(
          nome: nome,
          email: email,
          cargo: cargo,
          hasAccessUsuario: hasAccessUsuario,
          hasAccessCliente: hasAccessCliente,
          hasAccessFuncionario: hasAccessFuncionario,
          hasAccessVeiculo: hasAccessVeiculo,
          hasAccessPerfis: hasAccessPerfis,
          hasAccessOrdem: hasAccessOrdem,
        ),
      );
    } catch (e) {
      emit(const PainelFail('Deu rim'));
    }
  }

  Future<void> _onPainelAbrirCamera(
    PainelAbrirCamera event,
    Emitter<PainelState> emit,
  ) async {
    try {
      // final image = await _imageService.pickFromCamera();
    } catch (e) {
      emit(const PainelFail('Erro ao abrir a câmera'));
    }
  }

  Future<void> _onPainelAbrirGaleria(
    PainelAbrirGaleria event,
    Emitter<PainelState> emit,
  ) async {
    try {
      // final image = await _imageService.pickFromGallery();
    } catch (e) {
      emit(const PainelFail('Erro ao abrir a galeria'));
    }
  }
}
