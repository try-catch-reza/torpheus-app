import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:torpheus/data/datasources/remote/http_client.dart';
import 'package:torpheus/data/models/indicador_ordem_servico_model.dart';
import 'package:torpheus/data/models/indicador_ordem_servico_periodo_model.dart';

import '../../../../core/constants/enum/granularidade.dart';
import '../../../../domain/repositories/remote/eapi_remote_repository.dart';

part 'relatorios_event.dart';

part 'relatorios_state.dart';

class RelatoriosBloc extends Bloc<RelatoriosEvent, RelatoriosState> {
  late final EapiRemoteRepository _eapiRemoteRepository;

  RelatoriosBloc(this._eapiRemoteRepository)
      : super(const RelatoriosInitial()) {
    on<RelatoriosLoad>(_onRelatoriosLoad);
    on<RelatoriosSetDataInicio>(_onRelatoriosSetDataInicio);
    on<RelatoriosSetDataFim>(_onRelatoriosSetDataFim);
    on<RelatoriosAplicar>(_onRelatoriosAplicar);
    on<RelatoriosSetGranularidade>(_onRelatoriosSetGranularidade);
  }

  Future<void> _onRelatoriosLoad(
    RelatoriosLoad event,
    Emitter<RelatoriosState> emit,
  ) async {
    emit(const RelatoriosLoading());
    try {
      final relatorios =
          await _eapiRemoteRepository.getIndicadoresOrdensServico(
        startDate: DateTime.now().subtract(const Duration(days: 30)),
        endDate: DateTime.now(),
      );

      final indicadorPeriodo =
          await _eapiRemoteRepository.getIndicadoresOrdensServicoPeriodo(
        startDate: DateTime.now().subtract(const Duration(days: 30)),
        endDate: DateTime.now(),
        granularidade: Granularidade.mes,
      );

      emit(
        RelatoriosLoaded(
          indicador: relatorios,
          indicadorPeriodo: indicadorPeriodo,
          dataInicio: DateTime.now().subtract(const Duration(days: 30)),
          dataFim: DateTime.now(),
          granularidade: Granularidade.mes,
        ),
      );
    } on HttpRequestException catch (e) {
      emit(RelatoriosError(message: e.message));
    } catch (e) {
      emit(RelatoriosError(message: 'Erro ao carregar os relatórios: $e'));
    }
  }

  void _onRelatoriosSetDataInicio(
    RelatoriosSetDataInicio event,
    Emitter<RelatoriosState> emit,
  ) {
    emit(
      RelatoriosLoaded(
        indicador: state.indicador,
        dataInicio: event.dataInicio,
        dataFim: state.dataFim,
        indicadorPeriodo: state.indicadorPeriodo,
        granularidade: state.granularidade,
      ),
    );
  }

  void _onRelatoriosSetDataFim(
    RelatoriosSetDataFim event,
    Emitter<RelatoriosState> emit,
  ) {
    emit(
      RelatoriosLoaded(
        indicador: state.indicador,
        dataInicio: state.dataInicio,
        dataFim: event.dataFim,
        indicadorPeriodo: state.indicadorPeriodo,
        granularidade: state.granularidade,
      ),
    );
  }

  Future<void> _onRelatoriosAplicar(
    RelatoriosAplicar event,
    Emitter<RelatoriosState> emit,
  ) async {
    try {
      final relatorios =
          await _eapiRemoteRepository.getIndicadoresOrdensServico(
        startDate: state.dataInicio ??
            DateTime.now().subtract(const Duration(days: 30)),
        endDate: state.dataFim ?? DateTime.now(),
      );

      final indicadorPeriodo =
          await _eapiRemoteRepository.getIndicadoresOrdensServicoPeriodo(
        startDate: state.dataInicio ??
            DateTime.now().subtract(const Duration(days: 30)),
        endDate: state.dataFim ?? DateTime.now(),
        granularidade: state.granularidade ?? Granularidade.mes,
      );

      emit(
        RelatoriosLoaded(
          indicador: relatorios,
          dataInicio: state.dataInicio,
          dataFim: state.dataFim,
          indicadorPeriodo: indicadorPeriodo,
          granularidade: state.granularidade,
        ),
      );
    } on HttpRequestException catch (e) {
      emit(RelatoriosError(message: e.message));
    } catch (e) {
      emit(RelatoriosError(message: 'Erro ao carregar os relatórios: $e'));
    }
  }

  void _onRelatoriosSetGranularidade(
    RelatoriosSetGranularidade event,
    Emitter<RelatoriosState> emit,
  ) {
    emit(
      RelatoriosLoaded(
        indicador: state.indicador,
        dataInicio: state.dataInicio,
        dataFim: state.dataFim,
        indicadorPeriodo: state.indicadorPeriodo,
        granularidade: event.granularidade,
      ),
    );
  }
}
