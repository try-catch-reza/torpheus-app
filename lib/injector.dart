import 'package:get_it/get_it.dart';
import 'package:torpheus/presentation/screens/painel/bloc/painel_bloc.dart';
import 'package:torpheus/presentation/screens/login/bloc/login_bloc.dart';
import 'package:torpheus/presentation/screens/menu/bloc/menu_bloc.dart';
import 'package:torpheus/presentation/screens/recuperar_senha/bloc/recuperar_senha_bloc.dart';

import 'core/shared/app_system_info.dart';
import 'external/plugins/android_info_impl.dart';
import 'external/plugins/app_package_impl.dart';
import 'external/plugins/device_hardware_info_impl.dart';
import 'presentation/screens/authentication/authentication_bloc/authentication_bloc.dart';

import 'data/datasources/local/app_database.dart';
import 'data/datasources/local/shared_data.dart';
import 'data/datasources/remote/http_client.dart';
import 'data/repositories/preferences/preferences_local_repository_impl.dart';
import 'data/repositories/remote/eapi_remote_repository_impl.dart';
import 'domain/controller/authentication_controller.dart';
import 'domain/controller/preferences_controller.dart';
import 'domain/repositories/preferenfeces/preferences_local_repository.dart';
import 'domain/repositories/remote/eapi_remote_repository.dart';
import 'external/datasources/local/app_database_impl.dart';
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

    /// Database----------------------------------------------------------------
    getIt.registerSingletonAsync<ApplicationDatabase>(
      ApplicationDatabaseImpl.initialize,
    );

    getIt.registerSingletonAsync<SharedData>(SharedDataImpl.initialize);

    /// API Client--------------------------------------------------------------
    getIt.registerSingleton<HttpClient>(HttpClientImpl());

    /// Preferences Repository--------------------------------------------------
    getIt.registerSingleton<PreferencesLocalRepository>(
      PreferencesLocalRepositoryImpl(
        await getIt.getAsync<SharedData>(),
      ),
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
      ),
    );

    /// Controller--------------------------------------------------------------
    getIt.registerSingleton<PreferencesController>(
      PreferencesController(getIt<PreferencesLocalRepository>()),
    );

    getIt.registerSingleton<AuthenticationController>(
      AuthenticationController(
        getIt<EapiRemoteRepository>(),
      ),
    );

    /// BLoC--------------------------------------------------------------------

    getIt.registerSingleton<AuthenticationBloc>(
      AuthenticationBloc(
        getIt.get<AuthenticationController>(),
        getIt.get<PreferencesController>(),
      ),
    );

    getIt.registerSingleton<LoginBloc>(
      LoginBloc(
        getIt.get<PreferencesLocalRepository>(),
      ),
    );

    getIt.registerSingleton<PainelBloc>(
      PainelBloc(),
    );

    getIt.registerSingleton<MenuBloc>(
      MenuBloc(),
    );

    getIt.registerFactory<RecuperarSenhaBloc>(() => RecuperarSenhaBloc());

    return InjectorImpl._(getIt);
  }

  @override
  void dispose() {
    Future.wait([]);
  }
}
