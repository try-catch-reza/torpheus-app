import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:torpheus/core/constants/enum/status_ordem.dart';

import '../../../../data/models/ordem_servico_model.dart';
import '../../../../domain/controller/permissao_controller.dart';
import '../../../../domain/repositories/preferenfeces/preferences_local_repository.dart';
import '../../../../domain/repositories/remote/eapi_remote_repository.dart';

part 'painel_event.dart';

part 'painel_state.dart';

class PainelBloc extends Bloc<PainelEvent, PainelState> {
  late final PreferencesLocalRepository _preferencesLocalRepository;
  late final PermissaoController _permissaoController;
  late final EapiRemoteRepository _eapiRemoteRepository;

  PainelBloc(this._preferencesLocalRepository, this._permissaoController,
      this._eapiRemoteRepository)
      : super(const PainelInitial()) {
    on<PainelCarregar>(_onPainelLoad);
    on<PainelAbrirCamera>(_onPainelAbrirCamera);
    on<PainelAbrirGaleria>(_onPainelAbrirGaleria);
  }

  Future<void> _onPainelLoad(
    PainelCarregar event,
    Emitter<PainelState> emit,
  ) async {
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

    try {
      final ordens = await _eapiRemoteRepository.getOS();

      final ordensAndamentoAndPendente = ordens.where((ordem) {
        return ordem.statusOrdem == StatusOrdem.aberta ||
            ordem.statusOrdem == StatusOrdem.emProgresso;
      }).toList();

      final totalOrdensAbertas = ordens.where((ordem) {
        return ordem.statusOrdem == StatusOrdem.aberta;
      }).length;

      final totalOrdensAndamento = ordens.where((ordem) {
        return ordem.statusOrdem == StatusOrdem.emProgresso;
      }).length;

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
          ordens: ordensAndamentoAndPendente,
          totalOrdensAbertas: totalOrdensAbertas,
          totalOrdensAndamento: totalOrdensAndamento,
        ),
      );
    } catch (e) {
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
          ordens: const [],
          totalOrdensAbertas: 0,
          totalOrdensAndamento: 0,
        ),
      );
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
