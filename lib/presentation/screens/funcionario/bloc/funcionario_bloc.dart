import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../data/models/funcionario_model.dart';
import '../../../../domain/controller/permissao_controller.dart';
import '../../../../domain/repositories/remote/eapi_remote_repository.dart';

part 'funcionario_event.dart';

part 'funcionario_state.dart';

class FuncionarioBloc extends Bloc<FuncionarioEvent, FuncionarioState> {
  late final EapiRemoteRepository _eapiRemoteRepository;
  late final PermissaoController _permissaoController;

  FuncionarioBloc(
    this._eapiRemoteRepository,
    this._permissaoController,
  ) : super(const FuncionarioInitial()) {
    on<FuncionarioLoad>(_onFuncionarioLoad);
    on<FuncionarioCadastrar>(_onFuncionarioCadastrar);
    on<FuncionarioSearch>(_onFuncionarioSearch);
  }

  Future<void> _onFuncionarioLoad(
    FuncionarioLoad event,
    Emitter<FuncionarioState> emit,
  ) async {
    emit(const FuncionarioLoading());
    try {
      final funcionarios = await _eapiRemoteRepository.getFuncionarios();
      final hasCriarFuncionario = _permissaoController.podeCriarFuncionario;

      emit(
        FuncionarioLoaded(
          funcionarios: funcionarios,
          funcionariosFiltered: funcionarios,
          hasCriarFuncionario: hasCriarFuncionario,
        ),
      );
    } catch (e) {
      emit(FuncionarioError(e.toString()));
    }
  }

  void _onFuncionarioCadastrar(
    FuncionarioCadastrar event,
    Emitter<FuncionarioState> emit,
  ) {
    emit(const FuncionarioCadastrando());
  }

  void _onFuncionarioSearch(
    FuncionarioSearch event,
    Emitter<FuncionarioState> emit,
  ) {
    List<FuncionarioModel> funcionariosFiltered = [];

    if (event.search.isNotEmpty) {
      final search = event.search.toLowerCase().trim();
      funcionariosFiltered = state.funcionarios.where((f) {
        final nome = f.nome?.toLowerCase() ?? '';

        return nome.contains(search);
      }).toList();
    } else {
      funcionariosFiltered = state.funcionarios;
    }

    emit(
      FuncionarioLoaded(
        funcionarios: state.funcionarios,
        funcionariosFiltered: funcionariosFiltered,
        hasCriarFuncionario: state.hasCriarFuncionario,
        search: event.search,
      ),
    );
  }
}
