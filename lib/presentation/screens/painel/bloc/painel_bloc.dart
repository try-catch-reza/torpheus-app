import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/plugins/image_service.dart';

part 'painel_event.dart';

part 'painel_state.dart';

class PainelBloc extends Bloc<PainelEvent, PainelState> {
  late final ImageService _imageService;

  PainelBloc(this._imageService) : super(const PainelInitial()) {
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

      emit(const PainelLoaded());
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

      if (image != null) {
        emit(PainelLoaded(image: image));
        // Faça algo com a imagem selecionada
      }
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

      if (image != null) {
        emit(PainelLoaded(image: image));
        // Faça algo com a imagem selecionada
      }
    } catch (e) {
      emit(const PainelFail('Erro ao abrir a galeria'));
    }
  }
}
