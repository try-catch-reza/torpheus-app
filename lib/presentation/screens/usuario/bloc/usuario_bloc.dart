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
    on<UsuarioSearch>(_onUsuarioSearch);
  }

  Future<void> _onUsuariosLoad(
    UsuariosLoad event,
    Emitter<UsuarioState> emit,
  ) async {
    emit(const UsuarioLoading());

    try {
      final usuarios = await _eapiRemoteRepository.getUsuarios();
      final hasCriarUsuario = _permissaoController.podeCriarUsuario;

      emit(
        UsuarioLoaded(
          usuarios: usuarios,
          usuariosFiltered: usuarios,
          hasCriarUsuario: hasCriarUsuario,
        ),
      );
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

  void _onUsuarioSearch(
    UsuarioSearch event,
    Emitter<UsuarioState> emit,
  ) {
    List<UsuarioModel> usuariosFiltered = [];

    if (event.search.isNotEmpty) {
      final search = event.search.toLowerCase().trim();
      usuariosFiltered = state.usuarios.where((u) {
        final nome = u.nome?.toLowerCase() ?? '';
        final email = u.email?.toLowerCase() ?? '';

        return nome.contains(search) || email.contains(search);
      }).toList();
    } else {
      usuariosFiltered = state.usuarios;
    }

    emit(
      UsuarioLoaded(
        usuarios: state.usuarios,
        usuariosFiltered: usuariosFiltered,
        hasCriarUsuario: state.hasCriarUsuario,
        search: event.search,
      ),
    );
  }
}
