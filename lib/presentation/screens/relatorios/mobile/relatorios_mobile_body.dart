import 'package:flutter/material.dart';
import 'package:torpheus/presentation/screens/relatorios/bloc/relatorios_bloc.dart';
import 'package:torpheus/presentation/screens/relatorios/mobile/relatorios_mobile_cards.dart';
import 'package:torpheus/presentation/screens/relatorios/mobile/relatorios_mobile_filtro.dart';

import '../web/relatorios_web_grafico.dart';
import '../web/relatorios_web_grafico_barras.dart';

class RelatoriosMobileBody extends StatelessWidget {
  const RelatoriosMobileBody({super.key, required this.state});

  final RelatoriosState state;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const RelatoriosMobileFiltro(),
            const SizedBox(height: 16),
            RelatoriosMobileCards(state: state),
            const SizedBox(height: 16),
            RelatoriosWebGrafico(state: state),
            const SizedBox(height: 16),
            RelatoriosWebGraficoBarras(state: state),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
