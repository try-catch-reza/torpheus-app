import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:torpheus/data/models/usuario_model.dart';

import '../../../../data/datasources/remote/http_client.dart';
import '../../../../data/models/perfis_model.dart';
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
    on<CadastrarUsuarioSetPerfil>(_onCadastrarUsuarioSetPerfil);
  }

  Future<void> _onCadastrarUsuarioLoad(
    CadastrarUsuarioLoad event,
    Emitter<CadastrarUsuarioState> emit,
  ) async {
    emit(const CadastrarUsuarioLoading());
    final perfis = await _eapiRemoteRepository.getPerfis();
    emit(CadastrarUsuarioLoaded(perfis: perfis));
  }

  Future<void> _onCadastrarUsuarioSubmit(
    CadastrarUsuarioSubmit event,
    Emitter<CadastrarUsuarioState> emit,
  ) async {
    emit(CadastrarUsuarioLoading(perfilSelecionado: state.perfilSelecionado));
    try {
      final UsuarioModel usuario = UsuarioModel(
        nome: event.nome,
        email: event.email,
        senha: event.senha,
        roleId: state.perfilSelecionado?.id ?? '',
      );

      await _eapiRemoteRepository.cadastrarUsuario(usuario);
      emit(const CadastrarUsuarioSuccess());
    } on HttpRequestException catch (e) {
      emit(
        CadastrarUsuarioError(
          message: e.title,
        ),
      );
    } catch (e) {
      emit(
        CadastrarUsuarioError(
          message: 'Não foi possível cadastrar o usuário.\n$e',
        ),
      );
    }
  }

  void _onCadastrarUsuarioSetPerfil(
    CadastrarUsuarioSetPerfil event,
    Emitter<CadastrarUsuarioState> emit,
  ) {
    emit(
      CadastrarUsuarioLoaded(
        perfis: state.perfis,
        perfilSelecionado: event.perfil,
      ),
    );
  }
}
