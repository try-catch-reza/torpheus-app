import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/config/responsive.dart';
import 'package:torpheus/presentation/screens/servico/web/servico_web_content.dart';

import 'bloc/servico_bloc.dart';
import 'mobile/servico_mobile_content.dart';

class ServicoScreen extends StatelessWidget {
  const ServicoScreen({
    super.key,
    required this.servicoBloc,
    required this.arguments,
  });

  final ServicoBloc servicoBloc;
  final ServicoArguments arguments;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: servicoBloc
        ..add(
          ServicoLoad(
            ordemServicoId: arguments.ordemServicoid,
          ),
        ),
      child: Responsive.isDesktop(context) || Responsive.isTablet(context)
          ? const ServicoWebContent()
          : const ServicoMobileContent(),
    );
  }
}

class ServicoArguments {
  final String ordemServicoid;

  ServicoArguments(this.ordemServicoid);
}
