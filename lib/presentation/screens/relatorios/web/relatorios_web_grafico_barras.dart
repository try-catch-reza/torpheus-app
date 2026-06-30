import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:torpheus/presentation/screens/relatorios/bloc/relatorios_bloc.dart';

import '../../../../data/models/baldes_model.dart';

class RelatoriosWebGraficoBarras extends StatefulWidget {
  const RelatoriosWebGraficoBarras({super.key, required this.state});

  final RelatoriosState state;

  @override
  State<RelatoriosWebGraficoBarras> createState() =>
      _RelatoriosWebGraficoBarrasState();
}

class _RelatoriosWebGraficoBarrasState
    extends State<RelatoriosWebGraficoBarras> {
  int? _touchedIndex;

  List<BaldesModel> get _baldes => widget.state.indicadorPeriodo?.baldes ?? [];

  double get _maxY {
    if (_baldes.isEmpty) return 5;
    final max = _baldes
        .map((b) => (b.total ?? 0).toDouble())
        .reduce((a, b) => a > b ? a : b);
    return max == 0 ? 5 : max + 1;
  }

  String _formatarData(DateTime? date) {
    if (date == null) return '';
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}';
  }

  List<BarChartGroupData> get _barGroups {
    return List.generate(_baldes.length, (i) {
      final balde = _baldes[i];
      final total = (balde.total ?? 0).toDouble();
      final concluidas = (balde.completos ?? 0).toDouble();
      final emAndamento = (balde.emProgresso ?? 0).toDouble();
      final emAberto = (balde.totalAbertos ?? 0).toDouble();
      // final canceladas = (balde.cancelados ?? 0).toDouble();
      final isTouched = _touchedIndex == i;
      final hasValue = total > 0;

      return BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            toY: hasValue ? total : 0.15,
            width: isTouched ? 10 : 8,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
            color: Colors.transparent,
            rodStackItems: hasValue
                ? [
                    BarChartRodStackItem(
                        0, concluidas, const Color(0xFF12B76A)),
                    BarChartRodStackItem(concluidas, concluidas + emAndamento,
                        const Color(0xFF2E90FA)),
                    BarChartRodStackItem(
                        concluidas + emAndamento,
                        concluidas + emAndamento + emAberto,
                        const Color(0xFF6B7A99)),
                    BarChartRodStackItem(concluidas + emAndamento + emAberto,
                        total, const Color(0xFFF97066)),
                  ]
                : [
                    BarChartRodStackItem(0, 0.15, const Color(0xFFE8ECF0)),
                  ],
          ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
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
          // Header
          Row(
            children: [
              const Text(
                'OS por período',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1B2A4A),
                ),
              ),
              const Spacer(),
              if (widget.state.indicador?.dataInicio != null &&
                  widget.state.indicador?.dataFim != null)
                Text(
                  '${_formatarData(widget.state.indicador?.dataInicio)} — ${_formatarData(widget.state.indicador?.dataFim)}',
                  style:
                      const TextStyle(fontSize: 12, color: Color(0xFF6B7A99)),
                ),
            ],
          ),

          const SizedBox(height: 8),

          // Legenda
          const Wrap(
            spacing: 16,
            children: [
              _LegendaItem(label: 'Concluídas', color: Color(0xFF12B76A)),
              _LegendaItem(label: 'Em andamento', color: Color(0xFF2E90FA)),
              _LegendaItem(label: 'Em aberto', color: Color(0xFF6B7A99)),
              _LegendaItem(label: 'Canceladas', color: Color(0xFFF97066)),
            ],
          ),

          const SizedBox(height: 20),

          // Gráfico
          SizedBox(
            height: 180,
            child: _baldes.isEmpty
                ? const Center(
                    child: Text(
                      'Sem dados no período',
                      style: TextStyle(fontSize: 13, color: Color(0xFF6B7A99)),
                    ),
                  )
                : BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY: _maxY,
                      minY: 0,
                      groupsSpace: 4,
                      barTouchData: BarTouchData(
                        touchCallback: (event, response) {
                          setState(() {
                            if (!event.isInterestedForInteractions ||
                                response == null ||
                                response.spot == null) {
                              _touchedIndex = null;
                            } else {
                              _touchedIndex =
                                  response.spot!.touchedBarGroupIndex;
                            }
                          });
                        },
                        touchTooltipData: BarTouchTooltipData(
                          getTooltipColor: (_) => const Color(0xFF1B2A4A),
                          tooltipRoundedRadius: 8,
                          tooltipPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          getTooltipItem: (group, groupIndex, rod, rodIndex) {
                            final balde = _baldes[groupIndex];
                            if ((balde.total ?? 0) == 0) return null;

                            return BarTooltipItem(
                              '',
                              const TextStyle(),
                              children: [
                                TextSpan(
                                  text: '${balde.total} OS  ',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13,
                                  ),
                                ),
                                TextSpan(
                                  text: _formatarData(balde.data),
                                  style: const TextStyle(
                                    color: Color(0xFFB0C4DE),
                                    fontSize: 11,
                                  ),
                                ),
                                if ((balde.completos ?? 0) > 0)
                                  TextSpan(
                                    text: '\n✓ ${balde.completos} concluídas',
                                    style: const TextStyle(
                                        color: Color(0xFF6CE9A6), fontSize: 11),
                                  ),
                                if ((balde.emProgresso ?? 0) > 0)
                                  TextSpan(
                                    text:
                                        '\n◉ ${balde.emProgresso} em andamento',
                                    style: const TextStyle(
                                        color: Color(0xFF84CAFF), fontSize: 11),
                                  ),
                                if ((balde.totalAbertos ?? 0) > 0)
                                  TextSpan(
                                    text: '\n○ ${balde.totalAbertos} em aberto',
                                    style: const TextStyle(
                                        color: Color(0xFFD0D5DD), fontSize: 11),
                                  ),
                                if ((balde.cancelados ?? 0) > 0)
                                  TextSpan(
                                    text: '\n✕ ${balde.cancelados} canceladas',
                                    style: const TextStyle(
                                        color: Color(0xFFFDA29B), fontSize: 11),
                                  ),
                              ],
                            );
                          },
                        ),
                      ),
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 28,
                            interval: 1,
                            getTitlesWidget: (value, meta) {
                              if (value == 0 || value == meta.max) {
                                return const SizedBox.shrink();
                              }
                              return Text(
                                value.toInt().toString(),
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Color(0xFF6B7A99),
                                ),
                              );
                            },
                          ),
                        ),
                        rightTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        topTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 28,
                            getTitlesWidget: (value, meta) {
                              final i = value.toInt();
                              if (i < 0 || i >= _baldes.length) {
                                return const SizedBox.shrink();
                              }
                              if (i % 5 != 0) return const SizedBox.shrink();
                              return Padding(
                                padding: const EdgeInsets.only(top: 6),
                                child: Text(
                                  _formatarData(_baldes[i].data),
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: Color(0xFF6B7A99),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                        horizontalInterval: 1,
                        getDrawingHorizontalLine: (_) => const FlLine(
                          color: Color(0xFFF2F4F7),
                          strokeWidth: 1,
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      barGroups: _barGroups,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class _LegendaItem extends StatelessWidget {
  final String label;
  final Color color;

  const _LegendaItem({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 5),
        Text(label,
            style: const TextStyle(fontSize: 11, color: Color(0xFF6B7A99))),
      ],
    );
  }
}
