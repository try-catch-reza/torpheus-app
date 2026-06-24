import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:torpheus/core/constants/enum/status_ordem.dart';
import 'package:torpheus/core/constants/enum/status_servico.dart';
import 'package:torpheus/data/datasources/remote/http_client.dart';
import 'package:torpheus/data/models/ordem_servico_model.dart';
import 'package:torpheus/data/models/servico_model.dart';

import '../../../../data/models/funcionario_model.dart';
import '../../../../domain/repositories/remote/eapi_remote_repository.dart';

part 'servico_event.dart';

part 'servico_state.dart';

class ServicoBloc extends Bloc<ServicoEvent, ServicoState> {
  late final EapiRemoteRepository _eapiRemoteRepository;

  ServicoBloc(this._eapiRemoteRepository) : super(const ServicoInitial()) {
    on<ServicoLoad>(_onServicoLoad);
    on<ServicoSetFuncionario>(_onServicoSetFuncionario);
    on<ServicoSubmit>(_onServicoSubmit);
    on<ServicoUpdate>(_onServicoUpdate);
    on<ServicoTrocarStatus>(_onServicoTrocarStatus);
    on<ServicoTrocarStatusOS>(_onServicoTrocarStatusOrdem);
  }

  Future<void> _onServicoLoad(
    ServicoLoad event,
    Emitter<ServicoState> emit,
  ) async {
    try {
      emit(const ServicoLoading());

      final ordemServico = await _eapiRemoteRepository.getOSById(
        event.ordemServicoId,
      );

      final funcionarios = await _eapiRemoteRepository.getFuncionarios();

      emit(
        ServicoLoaded(
          ordemServico: ordemServico,
          funcionarios: funcionarios,
        ),
      );
    } on HttpRequestException catch (e) {
      emit(ServicoFail(message: e.message, ordemServico: state.ordemServico));
    } catch (e) {
      emit(
        ServicoFail(
          message: 'Erro ao tentar carregar os dados',
          ordemServico: state.ordemServico,
        ),
      );
    }
  }

  void _onServicoSetFuncionario(
    ServicoSetFuncionario event,
    Emitter<ServicoState> emit,
  ) {
    emit(
      ServicoLoaded(
        ordemServico: state.ordemServico,
        funcionarios: state.funcionarios,
        funcionarioSelecionado: event.funcionario,
      ),
    );
  }

  Future<void> _onServicoSubmit(
    ServicoSubmit event,
    Emitter<ServicoState> emit,
  ) async {
    try {
      emit(
        ServicoLoading(
          funcionarioSelecionado: state.funcionarioSelecionado,
          ordemServico: state.ordemServico,
        ),
      );

      final ServicoModel servico = ServicoModel(
        descricao: event.descricao,
        funcionarioId: state.funcionarioSelecionado?.id,
      );

      await _eapiRemoteRepository.adicionarServico(
        servico,
        state.ordemServico?.id ?? '',
      );

      emit(ServicoSalvo(ordemServico: state.ordemServico));
    } on HttpRequestException catch (e) {
      emit(ServicoFail(message: e.message, ordemServico: state.ordemServico));
    } catch (e) {
      emit(
        ServicoFail(
          message: 'Erro ao tentar carregar os dados',
          ordemServico: state.ordemServico,
        ),
      );
    }
  }

  Future<void> _onServicoUpdate(
    ServicoUpdate event,
    Emitter<ServicoState> emit,
  ) async {
    try {
      emit(
        ServicoLoading(
          funcionarioSelecionado: state.funcionarioSelecionado,
          ordemServico: state.ordemServico,
        ),
      );

      final ServicoModel servico = ServicoModel(
        id: event.servicoId,
        descricao: event.descricao,
        funcionarioId: state.funcionarioSelecionado?.id,
      );

      await _eapiRemoteRepository.updateDescricaoAndMecanico(
        servico,
        state.ordemServico?.id ?? '',
      );

      emit(ServicoAtualizado(ordemServico: state.ordemServico));
    } on HttpRequestException catch (e) {
      emit(ServicoFail(message: e.message, ordemServico: state.ordemServico));
    } catch (e) {
      emit(
        ServicoFail(
          message: 'Erro ao tentar carregar os dados',
          ordemServico: state.ordemServico,
        ),
      );
    }
  }

  Future<void> _onServicoTrocarStatus(
    ServicoTrocarStatus event,
    Emitter<ServicoState> emit,
  ) async {
    try {
      emit(
        ServicoLoading(
          funcionarioSelecionado: state.funcionarioSelecionado,
          ordemServico: state.ordemServico,
        ),
      );

      await _eapiRemoteRepository.updateStatusServico(
        event.status,
        state.ordemServico?.id ?? '',
        event.servicoId,
      );

      emit(ServicoConcluido(ordemServico: state.ordemServico));
    } on HttpRequestException catch (e) {
      emit(ServicoFail(message: e.message, ordemServico: state.ordemServico));
    } catch (e) {
      emit(
        ServicoFail(
          message: 'Erro ao tentar carregar os dados',
          ordemServico: state.ordemServico,
        ),
      );
    }
  }

  Future<void> _onServicoTrocarStatusOrdem(
    ServicoTrocarStatusOS event,
    Emitter<ServicoState> emit,
  ) async {
    try {
      emit(
        ServicoLoading(
          funcionarioSelecionado: state.funcionarioSelecionado,
          ordemServico: state.ordemServico,
        ),
      );

      await _eapiRemoteRepository.updateStatusOS(
        event.status,
        state.ordemServico?.id ?? '',
      );

      emit(ServicoConcluido(ordemServico: state.ordemServico));
    } on HttpRequestException catch (e) {
      emit(ServicoFail(message: e.message, ordemServico: state.ordemServico));
    } catch (e) {
      emit(
        ServicoFail(
          message: 'Erro ao tentar carregar os dados',
          ordemServico: state.ordemServico,
        ),
      );
    }
  }
}
