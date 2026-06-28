import 'package:get_it/get_it.dart';
import 'package:torpheus/config/eapi_schema.dart';
import 'package:torpheus/data/plugins/image_service.dart';
import 'package:torpheus/domain/controller/permissao_controller.dart';
import 'package:torpheus/external/plugins/image_service_impl.dart';
import 'package:torpheus/presentation/screens/cadastrar_cliente/bloc/cadastrar_cliente_bloc.dart';
import 'package:torpheus/presentation/screens/foto/bloc/foto_bloc.dart';
import 'package:torpheus/presentation/screens/cadastrar_funcionario/bloc/cadastrar_funcionario_bloc.dart';
import 'package:torpheus/presentation/screens/cadastrar_usuario/bloc/cadastrar_usuario_bloc.dart';
import 'package:torpheus/presentation/screens/cadastrar_veiculo/bloc/cadastrar_veiculo_bloc.dart';
import 'package:torpheus/presentation/screens/cliente/bloc/cliente_bloc.dart';
import 'package:torpheus/presentation/screens/cliente_detalhe/bloc/cliente_detalhe_bloc.dart';
import 'package:torpheus/presentation/screens/perfis/bloc/perfis_bloc.dart';
import 'package:torpheus/presentation/screens/usuario/bloc/usuario_bloc.dart';
import 'package:torpheus/presentation/screens/veiculo_detalhe/bloc/veiculo_detalhe_bloc.dart';
import 'package:torpheus/presentation/screens/funcionario_detalhe/bloc/funcionario_detalhe_bloc.dart';
import 'package:torpheus/presentation/screens/funcionario/bloc/funcionario_bloc.dart';
import 'package:torpheus/presentation/screens/ordens_servico/bloc/ordens_servico_bloc.dart';
import 'package:torpheus/presentation/screens/painel/bloc/painel_bloc.dart';
import 'package:torpheus/presentation/screens/login/bloc/login_bloc.dart';
import 'package:torpheus/presentation/screens/menu/bloc/menu_bloc.dart';
import 'package:torpheus/presentation/screens/perfil/bloc/perfil_bloc.dart';
import 'package:torpheus/presentation/screens/recuperar_senha/bloc/recuperar_senha_bloc.dart';
import 'package:torpheus/presentation/screens/veiculos/bloc/veiculos_bloc.dart';
import 'package:torpheus/presentation/screens/relatorios/bloc/relatorios_bloc.dart';
import 'package:torpheus/presentation/screens/servico/bloc/servico_bloc.dart';
import 'package:torpheus/presentation/screens/analise_servico/bloc/analise_servico_bloc.dart';

import 'core/shared/app_system_info.dart';
import 'external/plugins/android_info_impl.dart';
import 'external/plugins/app_package_impl.dart';
import 'external/plugins/device_hardware_info_impl.dart';
import 'presentation/screens/authentication/authentication_bloc/authentication_bloc.dart';

import 'data/datasources/local/shared_data.dart';
import 'data/datasources/remote/http_client.dart';
import 'data/repositories/preferences/preferences_local_repository_impl.dart';
import 'data/repositories/remote/eapi_remote_repository_impl.dart';
import 'domain/controller/preferences_controller.dart';
import 'domain/repositories/preferenfeces/preferences_local_repository.dart';
import 'domain/repositories/remote/eapi_remote_repository.dart';
import 'external/datasources/local/shared_data_impl.dart';
import 'external/datasources/remote/http_client_impl.dart';

final getIt = GetIt.instance;

abstract class Injector {
  Injector(this.getIt);

  late final GetIt getIt;

  void dispose();
}

final class InjectorImpl extends Injector {
  InjectorImpl._(super.getIt);

  static Future<Injector> initializeDependencies() async {
    final getIt = GetIt.instance;

    /// Plugins
    await AppSystemInfo.initialize(
      deviceHardwareInfo: DeviceHardwareInfoImpl(),
      appPackageInfo: AppPackageInfoImpl(),
      androidInfo: AndroidInfoImpl(),
    );

    getIt.registerSingleton<ImageService>(ImageServiceImpl());

    /// Database----------------------------------------------------------------
    // getIt.registerSingletonAsync<ApplicationDatabase>(
    //   ApplicationDatabaseImpl.initialize,
    // );

    getIt.registerSingletonAsync<SharedData>(SharedDataImpl.initialize);

    /// API Client--------------------------------------------------------------
    getIt.registerSingleton<HttpClient>(HttpClientImpl());

    /// Preferences Repository--------------------------------------------------
    getIt.registerSingleton<PreferencesLocalRepository>(
      PreferencesLocalRepositoryImpl(
        await getIt.getAsync<SharedData>(),
      ),
    );

    /// Schema -----------------------------------------------------------------
    getIt.registerSingleton<EapiSchema>(
      EapiSchema(),
    );

    /// Local Repository--------------------------------------------------------
    // getIt.registerSingleton<UsuAuthLocalRepository>(
    //   UsuAuthLocalRepositoryImpl(
    //     await getIt.getAsync<ApplicationDatabase>(),
    //   ),
    // );

    /// Remote Repository-------------------------------------------------------
    getIt.registerSingleton<EapiRemoteRepository>(
      EapiRemoteRepositoryImpl(
        getIt.get<HttpClient>(),
        getIt.get<EapiSchema>(),
      ),
    );

    /// Controller--------------------------------------------------------------
    getIt.registerSingleton<PreferencesController>(
      PreferencesController(getIt<PreferencesLocalRepository>()),
    );

    getIt.registerSingleton<PermissaoController>(
      PermissaoController(getIt.get<PreferencesLocalRepository>()),
    );

    /// BLoC--------------------------------------------------------------------

    getIt.registerSingleton<AuthenticationBloc>(
      AuthenticationBloc(
        getIt.get<PreferencesController>(),
        getIt.get<PreferencesLocalRepository>(),
      ),
    );

    getIt.registerSingleton<LoginBloc>(
      LoginBloc(
        getIt.get<PreferencesLocalRepository>(),
        getIt.get<EapiRemoteRepository>(),
      ),
    );

    getIt.registerSingleton<PainelBloc>(
      PainelBloc(
        getIt.get<PreferencesLocalRepository>(),
        getIt.get<PermissaoController>(),
        getIt.get<EapiRemoteRepository>(),
      ),
    );

    getIt.registerSingleton<MenuBloc>(
      MenuBloc(
        getIt.get<PreferencesLocalRepository>(),
      ),
    );

    getIt.registerFactory<RecuperarSenhaBloc>(() => RecuperarSenhaBloc());

    getIt.registerSingleton<PerfilBloc>(
      PerfilBloc(
        getIt.get<PreferencesLocalRepository>(),
      ),
    );

    getIt.registerSingleton<ClienteBloc>(
      ClienteBloc(
        getIt.get<EapiRemoteRepository>(),
        getIt.get<PermissaoController>(),
      ),
    );

    getIt.registerSingleton<FuncionarioBloc>(
      FuncionarioBloc(
        getIt.get<EapiRemoteRepository>(),
        getIt.get<PermissaoController>(),
      ),
    );

    getIt.registerSingleton<VeiculosBloc>(
      VeiculosBloc(
        getIt.get<EapiRemoteRepository>(),
        getIt.get<PermissaoController>(),
      ),
    );

    getIt.registerSingleton<OrdensServicoBloc>(
      OrdensServicoBloc(
        getIt.get<PermissaoController>(),
        getIt.get<EapiRemoteRepository>(),
      ),
    );

    getIt.registerSingleton<RelatoriosBloc>(
      RelatoriosBloc(
        getIt.get<EapiRemoteRepository>(),
      ),
    );

    getIt.registerFactory<ServicoBloc>(
      () => ServicoBloc(
        getIt.get<EapiRemoteRepository>(),
        getIt.get<PermissaoController>()
      ),
    );

    getIt.registerFactory<AnaliseServicoBloc>(
      () => AnaliseServicoBloc(
        getIt.get<EapiRemoteRepository>(),
        getIt.get<PermissaoController>(),
      ),
    );

    getIt.registerFactory<ClienteDetalheBloc>(
      () => ClienteDetalheBloc(
        getIt.get<PermissaoController>(),
      ),
    );

    getIt.registerSingleton<VeiculoDetalheBloc>(
      VeiculoDetalheBloc(
        getIt.get<PermissaoController>(),
        getIt.get<EapiRemoteRepository>(),
      ),
    );

    getIt.registerSingleton<FuncionarioDetalheBloc>(
      FuncionarioDetalheBloc(
        getIt.get<PermissaoController>(),
        getIt.get<EapiRemoteRepository>(),
      ),
    );

    getIt.registerFactory<FotoBloc>(
      () => FotoBloc(
        getIt.get<ImageService>(),
        getIt.get<EapiRemoteRepository>(),
      ),
    );

    getIt.registerSingleton<CadastrarClienteBloc>(
      CadastrarClienteBloc(
        getIt.get<EapiRemoteRepository>(),
      ),
    );

    getIt.registerFactory<CadastrarFuncionarioBloc>(
      () => CadastrarFuncionarioBloc(
        getIt.get<EapiRemoteRepository>(),
      ),
    );

    getIt.registerFactory<CadastrarVeiculoBloc>(
      () => CadastrarVeiculoBloc(
        getIt.get<EapiRemoteRepository>(),
        getIt.get<PermissaoController>(),
      ),
    );

    getIt.registerSingleton<CadastrarUsuarioBloc>(
      CadastrarUsuarioBloc(
        getIt.get<EapiRemoteRepository>(),
      ),
    );

    getIt.registerSingleton<PerfisBloc>(
      PerfisBloc(
        getIt.get<EapiRemoteRepository>(),
        getIt.get<PermissaoController>(),
      ),
    );

    getIt.registerSingleton<UsuarioBloc>(
      UsuarioBloc(
        getIt.get<EapiRemoteRepository>(),
        getIt.get<PermissaoController>(),
      ),
    );

    return InjectorImpl._(getIt);
  }

  @override
  void dispose() {
    Future.wait([]);
  }
}
