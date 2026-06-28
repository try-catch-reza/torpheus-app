import 'package:flutter/material.dart';
import 'package:torpheus/presentation/screens/analise_servico/bloc/analise_servico_bloc.dart';
import 'package:torpheus/presentation/screens/analise_servico/web/analise_servico_web_title.dart';

import 'analise_servico_web_header.dart';
import 'analise_servico_web_registrar_hora.dart';

class AnaliseServicoWebBody extends StatelessWidget {
  const AnaliseServicoWebBody({
    super.key,
    required this.state,
    required this.horaController,
    required this.minutoController,
    required this.notaController,
  });

  final AnaliseServicoState state;
  final TextEditingController horaController;
  final TextEditingController minutoController;
  final TextEditingController notaController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: [
          const AnaliseServicoWebHeader(),
          AnaliseServicoWebTitle(servico: state.servico),
          const SizedBox(height: 24),
          AnaliseServicoWebRegistrarHora(
            horaController: horaController,
            minutoController: minutoController,
            notaController: notaController,
            state: state,
          ),
        ],
      ),
    );
  }
}
