import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/plugins/image_service.dart';
import '../../../../domain/repositories/preferenfeces/preferences_local_repository.dart';

part 'painel_event.dart';

part 'painel_state.dart';

class PainelBloc extends Bloc<PainelEvent, PainelState> {
  late final ImageService _imageService;
  late final PreferencesLocalRepository _preferencesLocalRepository;

  PainelBloc(
    this._imageService,
    this._preferencesLocalRepository,
  ) : super(const PainelInitial()) {
    on<PainelCarregar>(_onPainelLoad);
    on<PainelAbrirCamera>(_onPainelAbrirCamera);
    on<PainelAbrirGaleria>(_onPainelAbrirGaleria);
  }

  Future<void> _onPainelLoad(
    PainelEvent event,
    Emitter<PainelState> emit,
  ) async {
    try {
      emit(const PainelLoading());

      bool hasAccessUsuario = false;
      bool hasAccessFuncionario = false;
      bool hasAccessCliente = false;
      bool hasAccessVeiculo = false;

      final nome = _preferencesLocalRepository.getNome();
      final email = _preferencesLocalRepository.getEmail();
      final cargo = _preferencesLocalRepository.getCargo();
      final permissoes = _preferencesLocalRepository.getListPermissions();

      if (permissoes.contains('users.read')) {
        hasAccessUsuario = true;
      }

      if (permissoes.contains('employees.read')) {
        hasAccessFuncionario = true;
      }

      if (permissoes.contains('clients.read')) {
        hasAccessCliente = true;
      }

      if (permissoes.contains('vehicles.read')) {
        hasAccessVeiculo = true;
      }

      emit(
        PainelLoaded(
          nome: nome,
          email: email,
          cargo: cargo,
          hasAccessUsuario: hasAccessUsuario,
          hasAccessCliente: hasAccessCliente,
          hasAccessFuncionario: hasAccessFuncionario,
          hasAccessVeiculo: hasAccessVeiculo,
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
      final image = await _imageService.pickFromCamera();
    } catch (e) {
      emit(const PainelFail('Erro ao abrir a câmera'));
    }
  }

  Future<void> _onPainelAbrirGaleria(
    PainelAbrirGaleria event,
    Emitter<PainelState> emit,
  ) async {
    try {
      final image = await _imageService.pickFromGallery();
    } catch (e) {
      emit(const PainelFail('Erro ao abrir a galeria'));
    }
  }
}
