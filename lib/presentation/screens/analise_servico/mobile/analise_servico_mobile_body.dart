import 'package:flutter/material.dart';
import 'package:torpheus/presentation/screens/analise_servico/bloc/analise_servico_bloc.dart';

import 'analise_servico_mobile_registrar.dart';
import 'analise_servico_mobile_registros.dart';
import 'analise_servico_mobile_title.dart';

class AnaliseServicoMobileBody extends StatelessWidget {
  const AnaliseServicoMobileBody({
    super.key,
    required this.state,
    required this.horasController,
    required this.minutosController,
    required this.notaController,
    required this.formKey,
  });

  final AnaliseServicoState state;
  final TextEditingController horasController;
  final TextEditingController minutosController;
  final TextEditingController notaController;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnaliseServicoMobileTitle(servico: state.servico),
          Visibility(
            visible: state.hasPodeRegistrar,
            child: const SizedBox(
              height: 16.0,
            ),
          ),
          Visibility(
            visible: state.hasPodeRegistrar,
            child: AnaliseServicoMobileRegistrar(
              state: state,
              horasController: horasController,
              minutosController: minutosController,
              notaController: notaController,
              formKey: formKey,
            ),
          ),
          const SizedBox(height: 16.0),
          if (state.servico?.registroTrabalho != null &&
              state.servico!.registroTrabalho!.isNotEmpty)
            AnaliseServicoMobileRegistros(state: state),
        ],
      ),
    );
  }
}
