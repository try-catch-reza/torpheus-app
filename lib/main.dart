import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'app.dart';
import 'config/flavor.dart';
import 'injector.dart';

void main() async {
  FlavorConfig(const bool.fromEnvironment('bool.env', defaultValue: true));

  final Injector injector = await _initializeApp();

  runApp(TorpheusApp(injector: injector));
}

Future<Injector> _initializeApp() async {

  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('pt_BR', null);

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  final Injector injector = await InjectorImpl.initializeDependencies();
  await _loadEssentialData(injector);
  return injector;
}

Future<void> _loadEssentialData(Injector injector) async {}
