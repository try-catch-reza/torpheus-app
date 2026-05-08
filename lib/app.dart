import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:torpheus/config/theme.dart';
import 'package:torpheus/presentation/screens/login/bloc/login_bloc.dart';

import 'config/routes.dart';
import 'injector.dart';
import 'presentation/components/flutter_banner.dart';

class TorpheusApp extends StatelessWidget {
  const TorpheusApp({super.key, required this.injector});

  final Injector injector;

  @override
  Widget build(BuildContext context) {
    return TargetApp(
      child: MultiBlocProvider(
        providers: [
          BlocProvider<LoginBloc>(
            create: (_) {
              return injector.getIt.get<LoginBloc>()
                ..add(const LoginInicializar());
            },
          )
        ],
        child: MaterialApp(
          builder: (context, widget) => ResponsiveBreakpoints.builder(
            breakpoints: [
              const Breakpoint(start: 0, end: 450, name: MOBILE),
              const Breakpoint(start: 451, end: 800, name: TABLET),
              const Breakpoint(start: 801, end: 1920, name: DESKTOP),
              const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
            ],
            child: widget!,
          ),
          title: 'Torpheus',
          debugShowCheckedModeBanner: false,
          onGenerateRoute: (settings) => Routes.router(settings, injector),
          initialRoute: AppRoutes.root.route,
          theme: AppTheme.theme(),
        ),
      ),
    );
  }
}
