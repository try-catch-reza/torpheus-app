import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:torpheus/data/datasources/remote/http_client.dart';
import 'package:torpheus/data/models/funcionario_model.dart';

import '../../../../data/models/cliente_model.dart';
import '../../../../data/models/ordem_servico_model.dart';
import '../../../../data/models/servico_model.dart';
import '../../../../data/models/veiculo_model.dart';
import '../../../../domain/controller/permissao_controller.dart';
import '../../../../domain/repositories/remote/eapi_remote_repository.dart';

part 'ordens_servico_event.dart';

part 'ordens_servico_state.dart';

class OrdensServicoBloc extends Bloc<OrdensServicoEvent, OrdensServicoState> {
  final PermissaoController _permissaoController;
  final EapiRemoteRepository _eapiRemoteRepository;

  OrdensServicoBloc(
    this._permissaoController,
    this._eapiRemoteRepository,
  ) : super(const OrdensServicoInitial()) {
    on<OrdensServicoLoad>(_onOrdensServicoLoad);
    on<OrdensServicoSetVeiculo>(_onOrdensServicoSetVeiculo);
    on<OrdensServicoSetCliente>(_onOrdensServicoSetCliente);
    on<OrdensServicoSubmit>(_onOrdensServicoSubmit);
    on<OrdensServicoSetFuncionario>(_onOrdensServicoSetFuncionario);
    on<OrdensServicoAddServico>(_onOrdensServicoAddServico);
    on<OrdensServicoSearch>(_onOrdensServicoSearch);
  }

  Future<void> _onOrdensServicoLoad(
    OrdensServicoLoad event,
    Emitter<OrdensServicoState> emit,
  ) async {
    emit(const OrdensServicoLoading());
    try {
      final ordensServico = await _eapiRemoteRepository.getOS();
      final cliente = await _eapiRemoteRepository.getClientes();
      final veiculo = await _eapiRemoteRepository.getVeiculos();
      final funcionarios = await _eapiRemoteRepository.getFuncionarios();

      final hasPodeCriar = _permissaoController.podeCriarOS;

      emit(
        OrdensServicoLoaded(
          ordensServico: ordensServico,
          ordensServicoFiltered: ordensServico,
          hasPodeCriar: hasPodeCriar,
          veiculos: veiculo,
          clientes: cliente,
          funcionarios: funcionarios,
        ),
      );
    } on HttpRequestException catch (e) {
      emit(
        OrdensServicoError(message: e.message),
      );
    } catch (e) {
      emit(
        const OrdensServicoError(message: 'Não foi possível carregar as OS'),
      );
    }
  }

  void _onOrdensServicoSetVeiculo(
    OrdensServicoSetVeiculo event,
    Emitter<OrdensServicoState> emit,
  ) {
    emit(
      OrdensServicoLoaded(
        clientes: state.clientes,
        veiculos: state.veiculos,
        hasPodeCriar: state.hasPodeCriar,
        ordensServicoFiltered: state.ordensServicoFiltered,
        ordensServico: state.ordensServico,
        clienteSelecionado: state.clienteSelecionado,
        veiculoSelecionado: event.veiculo,
        funcionarios: state.funcionarios,
      ),
    );
  }

  void _onOrdensServicoSetCliente(
    OrdensServicoSetCliente event,
    Emitter<OrdensServicoState> emit,
  ) {
    emit(
      OrdensServicoLoaded(
        clientes: state.clientes,
        veiculos: state.veiculos,
        hasPodeCriar: state.hasPodeCriar,
        ordensServicoFiltered: state.ordensServicoFiltered,
        ordensServico: state.ordensServico,
        clienteSelecionado: event.cliente,
        veiculoSelecionado: state.veiculoSelecionado,
        funcionarios: state.funcionarios,
      ),
    );
  }

  Future<void> _onOrdensServicoSubmit(
    OrdensServicoSubmit event,
    Emitter<OrdensServicoState> emit,
  ) async {
    emit(
      OrdensServicoSalvando(
        veiculoSelecionado: state.veiculoSelecionado,
        clienteSelecionado: state.clienteSelecionado,
      ),
    );
    try {
      final ordemServico = OrdemServicoModel(
        veiculoId: state.veiculoSelecionado?.id ?? '',
        clienteId: state.clienteSelecionado?.id ?? '',
        descricaoCliente: event.descricao,
      );

      await _eapiRemoteRepository.abrirOS(ordemServico);

      emit(const OrdensServicoSalvo());
    } on HttpRequestException catch (e) {
      emit(
        OrdensServicoError(message: e.message),
      );
    } catch (e) {
      emit(
        const OrdensServicoError(message: 'Não foi possível cadastrar a OS'),
      );
    }
  }

  void _onOrdensServicoSetFuncionario(
    OrdensServicoSetFuncionario event,
    Emitter<OrdensServicoState> emit,
  ) {
    emit(
      OrdensServicoLoaded(
        clientes: state.clientes,
        veiculos: state.veiculos,
        hasPodeCriar: state.hasPodeCriar,
        ordensServicoFiltered: state.ordensServicoFiltered,
        ordensServico: state.ordensServico,
        clienteSelecionado: state.clienteSelecionado,
        veiculoSelecionado: state.veiculoSelecionado,
        funcionarios: state.funcionarios,
        funcionarioSelecionado: event.funcionario,
      ),
    );
  }

  Future<void> _onOrdensServicoAddServico(
    OrdensServicoAddServico event,
    Emitter<OrdensServicoState> emit,
  ) async {
    emit(
      OrdensServicoSalvando(
        veiculoSelecionado: state.veiculoSelecionado,
        clienteSelecionado: state.clienteSelecionado,
        funcionarioSelecionado: state.funcionarioSelecionado,
      ),
    );
    try {
      final ServicoModel servico = ServicoModel(
        descricao: event.descricao,
        funcionarioId: state.funcionarioSelecionado?.id ?? '',
      );

      await _eapiRemoteRepository.adicionarServico(
        servico,
        event.id,
      );

      emit(const OrdensServicoSalvo());
    } on HttpRequestException catch (e) {
      emit(
        OrdensServicoError(message: e.message),
      );
    } catch (e) {
      emit(
        const OrdensServicoError(message: 'Não foi possível cadastrar a OS'),
      );
    }
  }

  void _onOrdensServicoSearch(
    OrdensServicoSearch event,
    Emitter<OrdensServicoState> emit,
  ) {
    final search = event.search.toLowerCase();

    final filtered = state.ordensServico.where((ordem) {
      final cliente = ordem.descricaoCliente?.toLowerCase() ?? '';
      final veiculo = ordem.veiculoModelo?.toLowerCase() ?? '';
      final placa = ordem.veiculoPlaca?.toUpperCase() ?? '';

      return cliente.contains(search) ||
          veiculo.contains(search) ||
          placa.contains(search);
    }).toList();

    emit(
      OrdensServicoLoaded(
        clientes: state.clientes,
        veiculos: state.veiculos,
        hasPodeCriar: state.hasPodeCriar,
        ordensServicoFiltered: filtered,
        ordensServico: state.ordensServico,
        clienteSelecionado: state.clienteSelecionado,
        veiculoSelecionado: state.veiculoSelecionado,
        funcionarios: state.funcionarios,
      ),
    );
  }
}
