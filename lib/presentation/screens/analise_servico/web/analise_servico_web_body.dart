import 'package:flutter/material.dart';
import 'package:torpheus/presentation/screens/analise_servico/bloc/analise_servico_bloc.dart';
import 'package:torpheus/presentation/screens/analise_servico/web/analise_servico_web_title.dart';

import 'analise_servico_web_header.dart';
import 'analise_servico_web_registrar_hora.dart';
import 'analise_servico_web_registros.dart';

class AnaliseServicoWebBody extends StatelessWidget {
  const AnaliseServicoWebBody({
    super.key,
    required this.state,
    required this.horaController,
    required this.minutoController,
    required this.notaController,
    required this.formKey,
  });

  final AnaliseServicoState state;
  final TextEditingController horaController;
  final TextEditingController minutoController;
  final TextEditingController notaController;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            AnaliseServicoWebHeader(state: state),
            AnaliseServicoWebTitle(servico: state.servico),
            Visibility(
              visible: state.hasPodeRegistrar,
              child: const SizedBox(height: 24),
            ),
            Visibility(
              visible: state.hasPodeRegistrar,
              child: AnaliseServicoWebRegistrarHora(
                formKey: formKey,
                horaController: horaController,
                minutoController: minutoController,
                notaController: notaController,
                state: state,
              ),
            ),
            const SizedBox(height: 24),
            if (state.servico?.registroTrabalho != null &&
                state.servico!.registroTrabalho!.isNotEmpty)
              AnaliseServicoWebRegistros(state: state),
          ],
        ),
      ),
    );
  }
}
