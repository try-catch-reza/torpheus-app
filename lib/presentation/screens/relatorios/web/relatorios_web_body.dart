import 'package:flutter/material.dart';
import 'package:torpheus/presentation/screens/relatorios/bloc/relatorios_bloc.dart';
import 'package:torpheus/presentation/screens/relatorios/web/relatorio_web_header.dart';
import 'package:torpheus/presentation/screens/relatorios/web/relatorios_web_cards.dart';
import 'package:torpheus/presentation/screens/relatorios/web/relatorios_web_filtro.dart';
import 'package:torpheus/presentation/screens/relatorios/web/relatorios_web_grafico.dart';
import 'package:torpheus/presentation/screens/relatorios/web/relatorios_web_grafico_barras.dart';

class RelatoriosWebBody extends StatefulWidget {
  const RelatoriosWebBody({super.key, required this.state});

  final RelatoriosState state;

  @override
  State<RelatoriosWebBody> createState() => _RelatoriosWebBodyState();
}

class _RelatoriosWebBodyState extends State<RelatoriosWebBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(44),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const RelatorioWebHeader(),
            const SizedBox(height: 24),
            const RelatoriosWebFiltro(),
            const SizedBox(height: 20),
            RelatoriosWebCards(state: widget.state),
            const SizedBox(height: 20),
            RelatoriosWebGrafico(state: widget.state),
            const SizedBox(height: 20),
            RelatoriosWebGraficoBarras(state: widget.state),
          ],
        ),
      ),
    );
  }
}
