import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../data/models/foto_model.dart';
import '../../../../data/plugins/image_service.dart';
import '../../../../domain/repositories/remote/eapi_remote_repository.dart';

part 'foto_event.dart';

part 'foto_state.dart';

class FotoBloc extends Bloc<FotoEvent, FotoState> {
  final ImageService _imageService;
  final EapiRemoteRepository _eapiRemoteRepository;

  FotoBloc(
    this._imageService,
    this._eapiRemoteRepository,
  ) : super(const FotoInitial()) {
    on<FotoCarregar>(_onFotoCarregar);
    on<FotoTirarFoto>(_onFotoTirarFoto);
    on<FotoSelecionarGaleria>(_onFotoSelecionarGaleria);
    on<FotoAdicionarArquivosWeb>(_onFotoAdicionarArquivosWeb);
    on<FotoRemoverFotoNova>(_onFotoRemoverFotoNova);
    on<FotoRemoverFotoExistente>(_onFotoRemoverFotoExistente);
    on<FotoRemoverFotoWeb>(_onFotoRemoverFotoWeb);
    on<FotoEnviarFotos>(_onFotoEnviarFotos);
  }

  Future<void> _onFotoCarregar(
    FotoCarregar event,
    Emitter<FotoState> emit,
  ) async {
    emit(
      FotoLoaded(
        fotosExistentes: event.fotosExistentes,
        fotosNovas: const [],
        fotosNovasWeb: const [],
      ),
    );
  }

  Future<void> _onFotoTirarFoto(
    FotoTirarFoto event,
    Emitter<FotoState> emit,
  ) async {
    try {
      emit(FotoLoading(
        fotosExistentes: state.fotosExistentes,
        fotosNovas: state.fotosNovas,
        fotosNovasWeb: state.fotosNovasWeb,
      ));
      final foto = await _imageService.pickFromCamera();
      if (foto != null) {
        final novaLista = List<File>.from(state.fotosNovas)..add(foto);
        emit(FotoLoaded(
          fotosExistentes: state.fotosExistentes,
          fotosNovas: novaLista,
          fotosNovasWeb: state.fotosNovasWeb,
        ));
      } else {
        emit(FotoLoaded(
          fotosExistentes: state.fotosExistentes,
          fotosNovas: state.fotosNovas,
          fotosNovasWeb: state.fotosNovasWeb,
        ));
      }
    } catch (e) {
      emit(FotoFail(
        'Erro ao acessar a câmera',
        fotosExistentes: state.fotosExistentes,
        fotosNovas: state.fotosNovas,
        fotosNovasWeb: state.fotosNovasWeb,
      ));
    }
  }

  Future<void> _onFotoSelecionarGaleria(
    FotoSelecionarGaleria event,
    Emitter<FotoState> emit,
  ) async {
    try {
      emit(FotoLoading(
        fotosExistentes: state.fotosExistentes,
        fotosNovas: state.fotosNovas,
        fotosNovasWeb: state.fotosNovasWeb,
      ));
      final foto = await _imageService.pickFromGallery();
      if (foto != null) {
        final novaLista = List<File>.from(state.fotosNovas)..add(foto);
        emit(FotoLoaded(
          fotosExistentes: state.fotosExistentes,
          fotosNovas: novaLista,
          fotosNovasWeb: state.fotosNovasWeb,
        ));
      } else {
        emit(FotoLoaded(
          fotosExistentes: state.fotosExistentes,
          fotosNovas: state.fotosNovas,
          fotosNovasWeb: state.fotosNovasWeb,
        ));
      }
    } catch (e) {
      emit(FotoFail(
        'Erro ao acessar a galeria',
        fotosExistentes: state.fotosExistentes,
        fotosNovas: state.fotosNovas,
        fotosNovasWeb: state.fotosNovasWeb,
      ));
    }
  }

  Future<void> _onFotoAdicionarArquivosWeb(
    FotoAdicionarArquivosWeb event,
    Emitter<FotoState> emit,
  ) async {
    try {
      emit(FotoLoading(
        fotosExistentes: state.fotosExistentes,
        fotosNovas: state.fotosNovas,
        fotosNovasWeb: state.fotosNovasWeb,
      ));
      final arquivos = await _imageService.pickMultipleFromGallery();
      if (arquivos.isNotEmpty) {
        final novaLista = List<XFile>.from(state.fotosNovasWeb)
          ..addAll(arquivos);
        emit(FotoLoaded(
          fotosExistentes: state.fotosExistentes,
          fotosNovas: state.fotosNovas,
          fotosNovasWeb: novaLista,
        ));
      } else {
        emit(FotoLoaded(
          fotosExistentes: state.fotosExistentes,
          fotosNovas: state.fotosNovas,
          fotosNovasWeb: state.fotosNovasWeb,
        ));
      }
    } catch (e) {
      emit(FotoFail(
        'Erro ao selecionar imagens',
        fotosExistentes: state.fotosExistentes,
        fotosNovas: state.fotosNovas,
        fotosNovasWeb: state.fotosNovasWeb,
      ));
    }
  }

  Future<void> _onFotoRemoverFotoNova(
    FotoRemoverFotoNova event,
    Emitter<FotoState> emit,
  ) async {
    final novaLista = List<File>.from(state.fotosNovas)..removeAt(event.index);
    emit(FotoLoaded(
      fotosExistentes: state.fotosExistentes,
      fotosNovas: novaLista,
      fotosNovasWeb: state.fotosNovasWeb,
    ));
  }

  Future<void> _onFotoRemoverFotoWeb(
    FotoRemoverFotoWeb event,
    Emitter<FotoState> emit,
  ) async {
    final novaLista = List<XFile>.from(state.fotosNovasWeb)
      ..removeAt(event.index);
    emit(FotoLoaded(
      fotosExistentes: state.fotosExistentes,
      fotosNovas: state.fotosNovas,
      fotosNovasWeb: novaLista,
    ));
  }

  Future<void> _onFotoRemoverFotoExistente(
    FotoRemoverFotoExistente event,
    Emitter<FotoState> emit,
  ) async {
    final novaLista = List<FotoModel>.from(state.fotosExistentes)
      ..removeWhere((f) => f.id == event.foto.id);
    emit(FotoLoaded(
      fotosExistentes: novaLista,
      fotosNovas: state.fotosNovas,
      fotosNovasWeb: state.fotosNovasWeb,
    ));
  }

  Future<void> _onFotoEnviarFotos(
    FotoEnviarFotos event,
    Emitter<FotoState> emit,
  ) async {
    try {
      emit(
        FotoUploadLoading(
          fotosExistentes: state.fotosExistentes,
          fotosNovas: state.fotosNovas,
          fotosNovasWeb: state.fotosNovasWeb,
        ),
      );

      // Mobile: File
      for (final foto in state.fotosNovas) {
        await _eapiRemoteRepository.uploadFoto(
          event.ordemServicoId,
          event.servicoId,
          foto,
        );
      }

      // Web: XFile
      for (final xFile in state.fotosNovasWeb) {
        await _eapiRemoteRepository.uploadFotoXFile(
          event.ordemServicoId,
          event.servicoId,
          xFile,
        );
      }

      emit(
        FotoUploadSuccess(
          fotosExistentes: state.fotosExistentes,
          fotosNovas: const [],
          fotosNovasWeb: const [],
        ),
      );
    } catch (e) {
      emit(
        FotoFail(
          'Erro ao enviar as fotos',
          fotosExistentes: state.fotosExistentes,
          fotosNovas: state.fotosNovas,
          fotosNovasWeb: state.fotosNovasWeb,
        ),
      );
    }
  }
}
