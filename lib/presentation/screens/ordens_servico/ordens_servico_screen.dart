import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/screens/ordens_servico/bloc/ordens_servico_bloc.dart';

import 'package:torpheus/presentation/screens/ordens_servico/web/ordens_servico_web_content.dart';
import 'package:torpheus/presentation/screens/ordens_servico/mobile/ordens_servico_mobile_content.dart';

import '../../../config/responsive.dart';

class OrdensServicoScreen extends StatelessWidget {
  const OrdensServicoScreen({super.key, required this.ordensServicoBloc});

  final OrdensServicoBloc ordensServicoBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: ordensServicoBloc..add(const OrdensServicoLoad()),
      child: Responsive.isDesktop(context) || Responsive.isTablet(context)
          ? const OrdensServicoWebContent()
          : const OrdensServicoMobileContent(),
    );
  }
}
