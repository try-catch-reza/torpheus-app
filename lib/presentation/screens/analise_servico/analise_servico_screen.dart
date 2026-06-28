import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/config/responsive.dart';
import 'package:torpheus/presentation/screens/analise_servico/bloc/analise_servico_bloc.dart';
import 'package:torpheus/presentation/screens/analise_servico/mobile/analise_servico_mobile_content.dart';
import 'package:torpheus/presentation/screens/analise_servico/web/analise_servico_web_content.dart';

class AnaliseServicoScreen extends StatelessWidget {
  const AnaliseServicoScreen({
    super.key,
    required this.analiseServicoBloc,
    required this.arguments,
  });

  final AnaliseServicoBloc analiseServicoBloc;
  final AnaliseServicoArguments arguments;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: analiseServicoBloc
        ..add(
          AnaliseServicoLoad(
            ordemServicoId: arguments.ordemServicoId,
            servicoId: arguments.servicoId,
          ),
        ),
      child: Responsive.isDesktop(context) || Responsive.isTablet(context)
          ? const AnaliseServicoWebContent()
          : const AnaliseServicoMobileContent(),
    );
  }
}

class AnaliseServicoArguments {
  final String ordemServicoId;
  final String servicoId;

  AnaliseServicoArguments({
    required this.ordemServicoId,
    required this.servicoId,
  });
}
