import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:torpheus/data/models/funcionario_model.dart';

import '../../../../domain/controller/permissao_controller.dart';
import '../../../../domain/repositories/remote/eapi_remote_repository.dart';

part 'funcionario_detalhe_event.dart';

part 'funcionario_detalhe_state.dart';

class FuncionarioDetalheBloc
    extends Bloc<FuncionarioDetalheEvent, FuncionarioDetalheState> {
  late final PermissaoController _permissaoController;
  late final EapiRemoteRepository _eapiRemoteRepository;

  FuncionarioDetalheBloc(
    this._permissaoController,
    this._eapiRemoteRepository,
  ) : super(const FuncionarioDetalheInitial()) {
    on<FuncionarioDetalheLoad>(_onFuncionarioDetalheLoad);
  }

  Future<void> _onFuncionarioDetalheLoad(
    FuncionarioDetalheLoad event,
    Emitter<FuncionarioDetalheState> emit,
  ) async {
    emit(const FuncionarioDetalheLoading());
    try {
      final hasEditarFuncionario =
          _permissaoController.podeAtualizarFuncionario;

      final funcionario = await _eapiRemoteRepository.getFuncionarioById(
        event.funcionario?.id ?? '',
      );

      emit(
        FuncionarioDetalheLoaded(
          funcionario: funcionario,
          hasEditarFuncionario: hasEditarFuncionario,
        ),
      );
    } catch (e) {
      emit(
        const FuncionarioDetalheError(
          'Não foi possível carregar o detalhe do funcionário',
        ),
      );
    }
  }
}
