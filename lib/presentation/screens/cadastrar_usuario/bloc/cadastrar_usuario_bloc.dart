import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:torpheus/data/models/usuario_model.dart';

import '../../../../data/datasources/remote/http_client.dart';
import '../../../../domain/repositories/remote/eapi_remote_repository.dart';

part 'cadastrar_usuario_event.dart';

part 'cadastrar_usuario_state.dart';

class CadastrarUsuarioBloc
    extends Bloc<CadastrarUsuarioEvent, CadastrarUsuarioState> {
  late final EapiRemoteRepository _eapiRemoteRepository;

  CadastrarUsuarioBloc(
    this._eapiRemoteRepository,
  ) : super(const CadastrarUsuarioInitial()) {
    on<CadastrarUsuarioLoad>(_onCadastrarUsuarioLoad);
    on<CadastrarUsuarioSubmit>(_onCadastrarUsuarioSubmit);
    on<CadastrarUsuarioUpdate>(_onCadastrarUsuarioUpdate);
    on<CadastrarUsuarioSetAtivo>(_onCadastrarUsuarioSetAtivo);
  }

  Future<void> _onCadastrarUsuarioLoad(
    CadastrarUsuarioLoad event,
    Emitter<CadastrarUsuarioState> emit,
  ) async {
    if (event.isEdit) {
      // final usuario = await _eapiRemoteRepository.getUsuarioById(
      //   event.usuarioId,
      // );

      // emit(
      //   CadastrarUsuarioEditando(
      //     usuarioEditar: usuario,
      //     isEdit: event.isEdit,
      //     usuarioId: event.usuarioId,
      //   ),
      // );
      //
      // emit(
      //   CadastrarUsuarioLoaded(
      //     usuarioEditar: usuario,
      //     usuarioId: event.usuarioId,
      //     isEdit: event.isEdit,
      //   ),
      // );

      return;
    }

    emit(
      CadastrarUsuarioLoaded(
        usuarioEditar: state.usuarioEditar,
      ),
    );
  }

  Future<void> _onCadastrarUsuarioSubmit(
    CadastrarUsuarioSubmit event,
    Emitter<CadastrarUsuarioState> emit,
  ) async {
    emit(const CadastrarUsuarioLoading());
    try {
      // await _eapiRemoteRepository.cadastrarUsuario(event.usuario);
      emit(const CadastrarUsuarioSuccess());
    } on HttpRequestException catch (e) {
      emit(
        CadastrarUsuarioError(
          message: e.title,
          isEdit: state.isEdit,
          usuarioId: state.usuarioId,
        ),
      );
    } catch (e) {
      emit(
        CadastrarUsuarioError(
          message: 'Não foi possível cadastrar o usuário.\n$e',
          usuarioId: state.usuarioId,
          isEdit: state.isEdit,
        ),
      );
    }
  }

  Future<void> _onCadastrarUsuarioUpdate(
    CadastrarUsuarioUpdate event,
    Emitter<CadastrarUsuarioState> emit,
  ) async {
    emit(
      CadastrarUsuarioLoading(
        usuarioId: state.usuarioId,
        isEdit: state.isEdit,
        usuarioEditar: state.usuarioEditar,
      ),
    );

    try {
      // await _eapiRemoteRepository.updateUsuario(event.usuario, state.usuarioId);
      emit(const CadastrarUsuarioAtualizado());
    } on HttpRequestException catch (e) {
      emit(
        CadastrarUsuarioError(
          message: e.title,
          isEdit: state.isEdit,
          usuarioId: state.usuarioId,
        ),
      );
    } catch (e) {
      emit(
        CadastrarUsuarioError(
          message: 'Não foi possível atualizar o usuário.\n$e',
          usuarioId: state.usuarioId,
          isEdit: state.isEdit,
        ),
      );
    }
  }

  void _onCadastrarUsuarioSetAtivo(
    CadastrarUsuarioSetAtivo event,
    Emitter<CadastrarUsuarioState> emit,
  ) {
    final usuarioAtualizado = state.usuarioEditar.copyWith(
      isActive: event.isAtivo,
    );

    emit(
      CadastrarUsuarioLoaded(
        usuarioEditar: usuarioAtualizado,
        isEdit: state.isEdit,
        usuarioId: state.usuarioId,
      ),
    );
  }
}

