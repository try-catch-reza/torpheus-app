import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:torpheus/core/constants/enum/status_ordem.dart';
import 'package:torpheus/core/constants/enum/status_servico.dart';
import 'package:torpheus/data/datasources/remote/http_client.dart';
import 'package:torpheus/data/models/ordem_servico_model.dart';
import 'package:torpheus/data/models/servico_model.dart';

import '../../../../data/models/funcionario_model.dart';
import '../../../../domain/controller/permissao_controller.dart';
import '../../../../domain/repositories/remote/eapi_remote_repository.dart';

part 'servico_event.dart';

part 'servico_state.dart';

class ServicoBloc extends Bloc<ServicoEvent, ServicoState> {
  late final EapiRemoteRepository _eapiRemoteRepository;
  late final PermissaoController _permissaoController;

  ServicoBloc(
    this._eapiRemoteRepository,
    this._permissaoController,
  ) : super(const ServicoInitial()) {
    on<ServicoLoad>(_onServicoLoad);
    on<ServicoSetFuncionario>(_onServicoSetFuncionario);
    on<ServicoSubmit>(_onServicoSubmit);
    on<ServicoUpdate>(_onServicoUpdate);
    on<ServicoTrocarStatus>(_onServicoTrocarStatus);
    on<ServicoTrocarStatusOS>(_onServicoTrocarStatusOrdem);
    on<ServicoSelecionarItem>(_onServicoSelecionarItem);
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

      final podeAdicionarServico = _permissaoController.podeAtualizarOS;

      final podeFinalizarOS = _permissaoController.podeGerenciarFoto;

      final podeGerenciarFoto = _permissaoController.podeGerenciarFoto;

      emit(
        ServicoLoaded(
          ordemServico: ordemServico,
          funcionarios: funcionarios,
          hasPodeAdicionarServico: podeAdicionarServico,
          hasPodeFinalizarOS: podeFinalizarOS,
          hasPodeGerenciarFoto: podeGerenciarFoto,
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
        hasPodeAdicionarServico: state.hasPodeAdicionarServico,
        hasPodeFinalizarOS: state.hasPodeFinalizarOS,
        hasPodeGerenciarFoto: state.hasPodeGerenciarFoto
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

      if (servico.funcionarioId != null &&
          state.ordemServico?.statusOrdem != StatusOrdem.emProgresso) {
        await _eapiRemoteRepository.updateStatusOS(
          StatusOrdem.emProgresso,
          state.ordemServico?.id ?? '',
        );
      }

      emit(
        ServicoSalvo(
          ordemServico: state.ordemServico,
          funcionarios: state.funcionarios,
          hasPodeAdicionarServico: state.hasPodeAdicionarServico,
          hasPodeFinalizarOS: state.hasPodeFinalizarOS,
          hasPodeGerenciarFoto: state.hasPodeGerenciarFoto
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

      if (servico.funcionarioId != null &&
          state.ordemServico?.statusOrdem != StatusOrdem.emProgresso) {
        await _eapiRemoteRepository.updateStatusOS(
          StatusOrdem.emProgresso,
          state.ordemServico?.id ?? '',
        );
      }

      emit(
        ServicoAtualizado(
          ordemServico: state.ordemServico,
          hasPodeAdicionarServico: state.hasPodeAdicionarServico,
          hasPodeFinalizarOS: state.hasPodeFinalizarOS,
          hasPodeGerenciarFoto: state.hasPodeGerenciarFoto
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

  void _onServicoSelecionarItem(
    ServicoSelecionarItem event,
    Emitter<ServicoState> emit,
  ) {
    emit(
      ServicoSelecionado(
        ordemServico: state.ordemServico,
        funcionarios: state.funcionarios,
        funcionarioSelecionado: state.funcionarioSelecionado,
        servicoSelecionado: event.servico,
        hasPodeAdicionarServico: state.hasPodeAdicionarServico,
        hasPodeFinalizarOS: state.hasPodeFinalizarOS,
        hasPodeGerenciarFoto: state.hasPodeGerenciarFoto
      ),
    );
  }
}
