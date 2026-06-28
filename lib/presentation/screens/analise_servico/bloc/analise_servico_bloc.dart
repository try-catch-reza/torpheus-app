import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:torpheus/data/datasources/remote/http_client.dart';
import 'package:torpheus/data/models/funcionario_model.dart';
import 'package:torpheus/data/models/ordem_servico_model.dart';
import 'package:torpheus/data/models/servico_model.dart';
import 'package:torpheus/domain/repositories/remote/eapi_remote_repository.dart';

import '../../../../domain/controller/permissao_controller.dart';

part 'analise_servico_event.dart';

part 'analise_servico_state.dart';

class AnaliseServicoBloc
    extends Bloc<AnaliseServicoEvent, AnaliseServicoState> {
  final EapiRemoteRepository _eapiRemoteRepository;
  late final PermissaoController _permissaoController;

  AnaliseServicoBloc(
    this._eapiRemoteRepository,
    this._permissaoController,
  ) : super(const AnaliseServicoInitial()) {
    on<AnaliseServicoLoad>(_onAnaliseServicoLoad);
    on<AnaliseServicoSetData>(_onAnaliseServicoSetData);
    on<AnaliseServicoSetFuncionario>(_onAnaliseServicoSetFuncionario);
    on<AnaliseServicoRegistrarHora>(_onAnaliseServicoRegistrarHora);
  }

  Future<void> _onAnaliseServicoLoad(
    AnaliseServicoLoad event,
    Emitter<AnaliseServicoState> emit,
  ) async {
    try {
      emit(AnaliseServicoLoading(servico: state.servico));

      final ordemServico = await _eapiRemoteRepository.getOSById(
        event.ordemServicoId,
      );

      final funcionarios = await _eapiRemoteRepository.getFuncionarios();

      final ServicoModel? servico = ordemServico.servicos?.firstWhere(
        (s) => s.id == event.servicoId,
        orElse: () => const ServicoModel(),
      );

      final funcionario = await _eapiRemoteRepository.getFuncionarioById(
        servico?.funcionarioId ?? '',
      );

      final hasPodeRegistrar = _permissaoController.podeRegistrarHora;

      emit(
        AnaliseServicoLoaded(
          servico: servico,
          funcionario: funcionario,
          funcionarios: funcionarios,
          data: DateTime.now(),
          ordemServico: ordemServico,
          hasPodeRegistrar: hasPodeRegistrar,
        ),
      );
    } on HttpRequestException catch (e) {
      emit(
        AnaliseServicoFail(
          message: e.message,
          servico: state.servico,
          ordemServico: state.ordemServico,
          funcionarios: state.funcionarios,
        ),
      );
    } catch (e) {
      emit(
        AnaliseServicoFail(
          message: 'Erro ao tentar carregar os dados do serviço',
          servico: state.servico,
        ),
      );
    }
  }

  void _onAnaliseServicoSetData(
    AnaliseServicoSetData event,
    Emitter<AnaliseServicoState> emit,
  ) {
    emit(
      AnaliseServicoLoaded(
        funcionario: state.funcionario,
        servico: state.servico,
        data: event.data,
        funcionarios: state.funcionarios,
        ordemServico: state.ordemServico,
        hasPodeRegistrar: state.hasPodeRegistrar,
      ),
    );
  }

  void _onAnaliseServicoSetFuncionario(
    AnaliseServicoSetFuncionario event,
    Emitter<AnaliseServicoState> emit,
  ) {
    emit(
      AnaliseServicoLoaded(
        funcionario: event.funcionario,
        servico: state.servico,
        data: state.data,
        funcionarios: state.funcionarios,
        ordemServico: state.ordemServico,
        hasPodeRegistrar: state.hasPodeRegistrar,
      ),
    );
  }

  Future<void> _onAnaliseServicoRegistrarHora(
    AnaliseServicoRegistrarHora event,
    Emitter<AnaliseServicoState> emit,
  ) async {
    try {
      final durationMinutes = (int.tryParse(event.hora) ?? 0) * 60 +
          (int.tryParse(event.minuto) ?? 0);

      await _eapiRemoteRepository.registrarWorkLog(
        ordemServicoId: state.ordemServico?.id ?? '',
        servicoId: state.servico?.id ?? '',
        durationMinutes: durationMinutes,
        performedAt: state.data ?? DateTime.now(),
        note: event.nota,
      );

      emit(
        AnaliseServicoHoraRegistrada(
          funcionario: state.funcionario,
          servico: state.servico,
          funcionarios: state.funcionarios,
          ordemServico: state.ordemServico,
          hasPodeRegistrar: state.hasPodeRegistrar,
        ),
      );
    } on HttpRequestException catch (e) {
      emit(
        AnaliseServicoFail(
          message: e.message,
          servico: state.servico,
          ordemServico: state.ordemServico,
          funcionarios: state.funcionarios,
        ),
      );
    } catch (e) {
      emit(
        AnaliseServicoFail(
          message: 'Erro ao tentar enviar os dados do serviço',
          servico: state.servico,
        ),
      );
    }
  }
}
