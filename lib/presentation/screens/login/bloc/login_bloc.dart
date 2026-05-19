import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:torpheus/core/utils/jwt_decoder.dart';
import 'package:torpheus/data/datasources/remote/http_client.dart';
import 'package:torpheus/data/models/auth_model.dart';
import 'package:torpheus/domain/repositories/remote/eapi_remote_repository.dart';

import '../../../../domain/repositories/preferenfeces/preferences_local_repository.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  late final EapiRemoteRepository _eapiRemoteRepository;
  late final PreferencesLocalRepository _preferencesLocalRepository;

  LoginBloc(
    this._preferencesLocalRepository,
    this._eapiRemoteRepository,
  ) : super(const LoginInitial()) {
    on<LoginInicializar>(_onLoginInicializar);
    on<LoginCarregar>(_onLoginCarregar);
    on<LoginMostrarSenha>(_onLoginMostrarSenha);
    on<LoginEnviar>(_onLoginEnviar);
  }

  void _onLoginInicializar(LoginInicializar event, Emitter<LoginState> emit) {
    emit(
      LoginLoaded(
        nome: '',
        senha: '',
        isMostrarSenha: state.isMostrarSenha,
      ),
    );
  }

  void _onLoginCarregar(LoginCarregar event, Emitter<LoginState> emit) {
    emit(
      LoginLoaded(
        nome: '',
        senha: '',
        isMostrarSenha: state.isMostrarSenha,
      ),
    );
  }

  void _onLoginMostrarSenha(
    LoginMostrarSenha event,
    Emitter<LoginState> emit,
  ) {
    emit(
      LoginLoaded(
        nome: state.nome,
        senha: state.senha,
        isMostrarSenha: state.isMostrarSenha == true ? false : true,
      ),
    );
  }

  Future<void> _onLoginEnviar(
    LoginEnviar event,
    Emitter<LoginState> emit,
  ) async {
    try {
      emit(
        LoginLoading(
          nome: event.senha,
          senha: event.email,
          isMostrarSenha: state.isMostrarSenha,
        ),
      );

      final AuthModel auth = AuthModel(
        email: event.email,
        password: event.senha,
        slug: 'teste-huandres',
      );

      final authResponse = await _eapiRemoteRepository.auth(auth);

      final permissions = JwtDecoder.getPermissions(
        authResponse.acessToken ?? '',
      );

      final nome = JwtDecoder.getNome(authResponse.acessToken ?? '');

      await Future.wait([
        _preferencesLocalRepository.saveAccessToken(
          authResponse.acessToken ?? '',
        ),
        _preferencesLocalRepository.saveIsUsuarioLogado(true),
        _preferencesLocalRepository.saveListPermissions(permissions),
        _preferencesLocalRepository.saveEmail(event.email),
        _preferencesLocalRepository.saveNome(nome),
      ]);

      emit(
        LoginAutenticado(
          nome: event.senha,
          senha: event.email,
          isMostrarSenha: state.isMostrarSenha,
        ),
      );
    } on HttpRequestException catch (e) {
      emit(
        LoginFail(
          message: e.message,
          nome: event.email,
          senha: event.senha,
          isMostrarSenha: state.isMostrarSenha,
        ),
      );
    } catch (e) {
      emit(
        LoginFail(
          message: 'Não foi possível se autenticar no app.\n'
              'Tente novamente caso persistir tente mais tarde\n$e',
          nome: event.email,
          senha: event.senha,
          isMostrarSenha: state.isMostrarSenha,
        ),
      );
    }
  }
}
