import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:torpheus/data/models/mecanico_model.dart';

import '../../../../domain/repositories/remote/eapi_remote_repository.dart';

part 'cadastrar_funcionario_event.dart';

part 'cadastrar_funcionario_state.dart';

class CadastrarFuncionarioBloc
    extends Bloc<CadastrarFuncionarioEvent, CadastrarFuncionarioState> {
  late final EapiRemoteRepository _eapiRemoteRepository;

  CadastrarFuncionarioBloc(
    this._eapiRemoteRepository,
  ) : super(const CadastrarFuncionarioInitial()) {
    on<CadastrarFuncionarioLoad>(_onCadastrarFuncionarioLoad);
    on<CadastrarFuncionarioSubmit>(_onCadastrarFuncionarioSubmit);
  }

  void _onCadastrarFuncionarioLoad(
    CadastrarFuncionarioLoad event,
    Emitter<CadastrarFuncionarioState> emit,
  ) {
    emit(
      const CadastrarFuncionarioLoaded(),
    );
  }

  Future<void> _onCadastrarFuncionarioSubmit(
    CadastrarFuncionarioSubmit event,
    Emitter<CadastrarFuncionarioState> emit,
  ) async {
    try {
      emit(const CadastrarFuncionarioLoading());

      await _eapiRemoteRepository.cadastrarFuncionario(event.funcionario);

      emit(const CadastrarFuncionarioSuccess());
    } catch (e) {
      emit(
        CadastrarFuncionarioError(
          'Não foi possível cadastrar o mecânico.\n$e',
        ),
      );
    }
  }
}
