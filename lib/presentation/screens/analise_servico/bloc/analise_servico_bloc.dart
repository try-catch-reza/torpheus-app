import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:torpheus/data/datasources/remote/http_client.dart';
import 'package:torpheus/data/models/funcionario_model.dart';
import 'package:torpheus/data/models/servico_model.dart';
import 'package:torpheus/domain/repositories/remote/eapi_remote_repository.dart';

part 'analise_servico_event.dart';

part 'analise_servico_state.dart';

class AnaliseServicoBloc
    extends Bloc<AnaliseServicoEvent, AnaliseServicoState> {
  final EapiRemoteRepository _eapiRemoteRepository;

  AnaliseServicoBloc(this._eapiRemoteRepository)
      : super(const AnaliseServicoInitial()) {
    on<AnaliseServicoLoad>(_onAnaliseServicoLoad);
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

      final ServicoModel? servico = ordemServico.servicos?.firstWhere(
        (s) => s.id == event.servicoId,
        orElse: () => const ServicoModel(),
      );

      final funcionario = await _eapiRemoteRepository.getFuncionarioById(
        servico?.funcionarioId ?? '',
      );

      emit(AnaliseServicoLoaded(servico: servico, funcionario: funcionario));
    } on HttpRequestException catch (e) {
      emit(AnaliseServicoFail(message: e.message, servico: state.servico));
    } catch (e) {
      emit(
        AnaliseServicoFail(
          message: 'Erro ao tentar carregar os dados do serviço',
          servico: state.servico,
        ),
      );
    }
  }
}
