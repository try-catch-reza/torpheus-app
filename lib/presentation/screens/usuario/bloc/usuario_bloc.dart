import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/models/usuario_model.dart';
import '../../../../domain/controller/permissao_controller.dart';
import '../../../../domain/repositories/remote/eapi_remote_repository.dart';

part 'usuario_event.dart';

part 'usuario_state.dart';

class UsuarioBloc extends Bloc<UsuarioEvent, UsuarioState> {
  final EapiRemoteRepository _eapiRemoteRepository;
  final PermissaoController _permissaoController;

  UsuarioBloc(this._eapiRemoteRepository, this._permissaoController)
      : super(const UsuarioInitial()) {
    on<UsuariosLoad>(_onUsuariosLoad);
    on<UsuarioSelecionar>(_onUsuarioSelecionar);
  }

  Future<void> _onUsuariosLoad(
    UsuariosLoad event,
    Emitter<UsuarioState> emit,
  ) async {
    emit(const UsuarioLoading());

    try {
      final usuarios = await _eapiRemoteRepository.getUsuarios();
      final hasCriarUsuario = _permissaoController.podeCriarUsuario;

      emit(UsuarioLoaded(usuarios: usuarios, hasCriarUsuario: hasCriarUsuario));
    } catch (e) {
      emit(UsuarioError('Não foi possível carregar os usuários\n$e'));
    }
  }

  void _onUsuarioSelecionar(
    UsuarioSelecionar event,
    Emitter<UsuarioState> emit,
  ) {
    emit(
      UsuarioSelecionado(
        usuarios: state.usuarios,
        usuarioSelecionado: event.usuario,
      ),
    );
  }
}
