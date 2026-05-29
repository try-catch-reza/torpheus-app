import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:torpheus/data/models/mecanico_model.dart';

import '../../../../domain/repositories/remote/eapi_remote_repository.dart';

part 'cadastrar_mecanico_event.dart';

part 'cadastrar_mecanico_state.dart';

class CadastrarMecanicoBloc
    extends Bloc<CadastrarMecanicoEvent, CadastrarMecanicoState> {
  late final EapiRemoteRepository _eapiRemoteRepository;

  CadastrarMecanicoBloc(
    this._eapiRemoteRepository,
  ) : super(const CadastrarMecanicoInitial()) {
    on<CadastrarMecanicoLoad>(_onCadastrarMecanicoLoad);
    on<CadastrarMecanicoSubmit>(_onCadastrarMecanicoSubmit);
  }

  void _onCadastrarMecanicoLoad(
    CadastrarMecanicoLoad event,
    Emitter<CadastrarMecanicoState> emit,
  ) {
    emit(
      const CadastrarMecanicoLoaded(),
    );
  }

  Future<void> _onCadastrarMecanicoSubmit(
    CadastrarMecanicoSubmit event,
    Emitter<CadastrarMecanicoState> emit,
  ) async {
    try {
      emit(const CadastrarMecanicoLoading());

      await _eapiRemoteRepository.cadastrarFuncionario(event.funcionario);

      emit(const CadastrarMecanicoSuccess());
    } catch (e) {
      emit(
        CadastrarMecanicoError(
          'Não foi possível cadastrar o mecânico.\n$e',
        ),
      );
    }
  }
}
