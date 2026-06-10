import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/datasources/remote/http_client.dart';
import '../../../../data/models/perfis_model.dart';
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
    on<UsuarioSearch>(_onUsuarioSearch);
    on<UsuarioSubmit>(_onUsuarioSubmit);
    on<UsuarioSetPerfil>(_onUsuarioSetPerfil);
  }

  Future<void> _onUsuariosLoad(
    UsuariosLoad event,
    Emitter<UsuarioState> emit,
  ) async {
    emit(const UsuarioLoading());

    try {
      final usuarios = await _eapiRemoteRepository.getUsuarios();
      final perfis = await _eapiRemoteRepository.getPerfis();
      final hasCriarUsuario = _permissaoController.podeCriarUsuario;
      final hasEditarUsuario = _permissaoController.podeAtualizarUsuario;

      emit(
        UsuarioLoaded(
          usuarios: usuarios,
          usuariosFiltered: usuarios,
          hasCriarUsuario: hasCriarUsuario,
          hasEditarUsuario: hasEditarUsuario,
          perfis: perfis,
        ),
      );
    } catch (e) {
      emit(UsuarioError('Não foi possível carregar os usuários\n$e'));
    }
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

  Future<void> _onUsuarioSubmit(
    UsuarioSubmit event,
    Emitter<UsuarioState> emit,
  ) async {
    emit(
      UsuarioSalvando(
        perfilSelecionado: state.perfilSelecionado,
        perfis: state.perfis,
        usuarios: state.usuarios,
        usuariosFiltered: state.usuariosFiltered,
      ),
    );
    try {
      final UsuarioModel usuario = UsuarioModel(
        nome: event.nome,
        email: event.email,
        senha: event.senha,
        roleId: state.perfilSelecionado?.id ?? '',
        isActive: true,
      );

      await _eapiRemoteRepository.cadastrarUsuario(usuario);
      emit(const UsuarioSalvo());
    } on HttpRequestException catch (e) {
      emit(UsuarioError(e.title));
    } catch (e) {
      emit(
        UsuarioError(
          'Não foi possível cadastrar o usuário.\n$e',
        ),
      );
    }
  }

  void _onUsuarioSetPerfil(
    UsuarioSetPerfil event,
    Emitter<UsuarioState> emit,
  ) {
    emit(
      UsuarioLoaded(
        usuarios: state.usuarios,
        usuariosFiltered: state.usuariosFiltered,
        hasCriarUsuario: state.hasCriarUsuario,
        perfilSelecionado: event.perfil,
        perfis: state.perfis,
        hasEditarUsuario: state.hasEditarUsuario,
      ),
    );
  }
}
