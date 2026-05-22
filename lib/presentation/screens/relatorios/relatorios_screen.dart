import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/screens/relatorios/bloc/relatorios_bloc.dart';

import 'package:torpheus/presentation/screens/relatorios/web/relatorios_web_content.dart';
import 'package:torpheus/presentation/screens/relatorios/mobile/relatorios_mobile_content.dart';

import '../../../config/responsive.dart';

class RelatoriosScreen extends StatelessWidget {
  const RelatoriosScreen({super.key, required this.relatoriosBloc});

  final RelatoriosBloc relatoriosBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: relatoriosBloc..add(const RelatoriosLoad()),
      child: Responsive.isDesktop(context) || Responsive.isTablet(context)
          ? const RelatoriosWebContent()
          : const RelatoriosMobileContent(),
    );
  }
}
