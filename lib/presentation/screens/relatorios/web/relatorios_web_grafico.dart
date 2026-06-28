import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:torpheus/presentation/screens/relatorios/bloc/relatorios_bloc.dart';

class RelatoriosWebGrafico extends StatelessWidget {
  const RelatoriosWebGrafico({super.key, required this.state});

  final RelatoriosState state;

  @override
  Widget build(BuildContext context) {
    final secoes = [
      (
        label: 'Concluídas',
        valor: state.indicador?.ordensConcluidas ?? 0,
        color: const Color(0xFF12B76A)
      ),
      (
        label: 'Não realizadas',
        valor: state.indicador?.ordensCanceladas ?? 0,
        color: const Color(0xFFF97066)
      ),
      (
        label: 'Em aberto',
        valor: state.indicador?.ordensAbertas ?? 0,
        color: const Color(0xFF2E90FA)
      ),
      (
        label: 'Andamento',
        valor: state.indicador?.ordensAndamento ?? 0,
        color: Colors.amber,
      ),
    ];

    final total = secoes.fold(0.0, (sum, s) => sum + s.valor);
    int? _touchedIndex;

    return StatefulBuilder(
      builder: (context, setState) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE8ECF0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Text(
                    'OS por status',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1B2A4A),
                    ),
                  ),
                  Spacer(),
                  Text(
                    'Mês atual',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF6B7A99),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  // Gráfico
                  SizedBox(
                    height: 180,
                    width: 180,
                    child: PieChart(
                      PieChartData(
                        sectionsSpace: 3,
                        centerSpaceRadius: 52,
                        pieTouchData: PieTouchData(
                          touchCallback: (event, response) {
                            setState(() {
                              if (!event.isInterestedForInteractions ||
                                  response == null ||
                                  response.touchedSection == null) {
                                _touchedIndex = null;
                              } else {
                                _touchedIndex = response
                                    .touchedSection!.touchedSectionIndex;
                              }
                            });
                          },
                        ),
                        sections: List.generate(secoes.length, (i) {
                          final s = secoes[i];
                          final isTouched = _touchedIndex == i;
                          final pct =
                              (s.valor / total * 100).toStringAsFixed(0);
                          return PieChartSectionData(
                            value: double.tryParse(s.valor.toString()),
                            color: s.color,
                            radius: isTouched ? 58 : 50,
                            title: '$pct%',
                            titleStyle: TextStyle(
                              fontSize: isTouched ? 14 : 12,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          );
                        }),
                      ),
                    ),
                  ),

                  // Centro label ao tocar
                  const SizedBox(width: 32),

                  // Legenda
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(secoes.length, (i) {
                        final s = secoes[i];
                        final pct = (s.valor / total * 100).toStringAsFixed(0);
                        final isActive = _touchedIndex == i;
                        return GestureDetector(
                          onTap: () => setState(
                              () => _touchedIndex = isActive ? null : i),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 150),
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: isActive
                                  ? s.color.withOpacity(0.06)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: isActive
                                    ? s.color.withOpacity(0.3)
                                    : Colors.transparent,
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    color: s.color,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(s.label,
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: isActive
                                            ? FontWeight.w700
                                            : FontWeight.w500,
                                        color: const Color(0xFF1B2A4A),
                                      )),
                                ),
                                Text(
                                  '$pct%',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: s.color,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  '(${s.valor.toInt()})',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF6B7A99),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
