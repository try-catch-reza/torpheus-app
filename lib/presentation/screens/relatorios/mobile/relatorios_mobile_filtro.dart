import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/enum/granularidade.dart';
import '../bloc/relatorios_bloc.dart';

class RelatoriosMobileFiltro extends StatefulWidget {
  const RelatoriosMobileFiltro({super.key});

  @override
  State<RelatoriosMobileFiltro> createState() => _RelatoriosMobileFiltroState();
}

class _RelatoriosMobileFiltroState extends State<RelatoriosMobileFiltro> {
  Future<void> _selecionarData(BuildContext context, bool isInicio) async {
    final bloc = context.read<RelatoriosBloc>();

    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF1B2A4A),
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Color(0xFF1B2A4A),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked == null) return;

    if (isInicio) {
      bloc.add(RelatoriosSetDataInicio(dataInicio: picked));
    } else {
      bloc.add(RelatoriosSetDataFim(dataFim: picked));
    }
  }

  String _formatarData(DateTime? data) {
    if (data == null) return 'dd/mm/aaaa';
    return '${data.day.toString().padLeft(2, '0')}/${data.month.toString().padLeft(2, '0')}/${data.year}';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RelatoriosBloc, RelatoriosState>(
      builder: (context, state) {
        final temFiltro = state.dataInicio != null && state.dataFim != null;

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE8ECF0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Label
              const Text(
                'PERÍODO',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF6B7A99),
                  letterSpacing: 0.8,
                ),
              ),
              const SizedBox(height: 10),

              // Datas — linha única
              Row(
                children: [
                  Expanded(
                    child: _MobileDateBox(
                      label: 'De',
                      valor: _formatarData(state.dataInicio),
                      preenchido: state.dataInicio != null,
                      onTap: () => _selecionarData(context, true),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child:
                        Text('—', style: TextStyle(color: Color(0xFF6B7A99))),
                  ),
                  Expanded(
                    child: _MobileDateBox(
                      label: 'Até',
                      valor: _formatarData(state.dataFim),
                      preenchido: state.dataFim != null,
                      enabled: state.dataInicio != null,
                      onTap: () => _selecionarData(context, false),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // Granularidade
              _MobileGranularidadeDropdown(
                valor: state.granularidade,
                onChanged: (value) {
                  context.read<RelatoriosBloc>().add(
                        RelatoriosSetGranularidade(granularidade: value!),
                      );
                },
              ),

              const SizedBox(height: 12),

              // Botões
              Row(
                children: [
                  if (temFiltro)
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: InkWell(
                        onTap: () {
                          context.read<RelatoriosBloc>()
                            ..add(
                                const RelatoriosSetDataInicio(dataInicio: null))
                            ..add(const RelatoriosSetDataFim(dataFim: null))
                            ..add(const RelatoriosAplicar());
                        },
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF2F4F7),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.close_rounded,
                              size: 18, color: Color(0xFF6B7A99)),
                        ),
                      ),
                    ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: temFiltro
                          ? () => context
                              .read<RelatoriosBloc>()
                              .add(const RelatoriosAplicar())
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1B2A4A),
                        disabledBackgroundColor: const Color(0xFFE8ECF0),
                        disabledForegroundColor: const Color(0xFF6B7A99),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        textStyle: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text('Aplicar'),
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

// ── Date Box Mobile ────────────────────────────────────────────────────────

class _MobileDateBox extends StatelessWidget {
  final String label;
  final String valor;
  final bool preenchido;
  final bool enabled;
  final VoidCallback onTap;

  const _MobileDateBox({
    required this.label,
    required this.valor,
    required this.onTap,
    this.preenchido = false,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: enabled ? Colors.white : const Color(0xFFF9FAFB),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color:
                preenchido ? const Color(0xFF1B2A4A) : const Color(0xFFE8ECF0),
          ),
        ),
        child: Row(
          children: [
            Text(
              '$label  ',
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Color(0xFF6B7A99),
              ),
            ),
            Icon(Icons.calendar_today_outlined,
                size: 13,
                color: preenchido
                    ? const Color(0xFF1B2A4A)
                    : const Color(0xFF6B7A99)),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                valor,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: preenchido ? FontWeight.w600 : FontWeight.w400,
                  color: preenchido
                      ? const Color(0xFF1B2A4A)
                      : const Color(0xFFB0BAD0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Granularidade Mobile ───────────────────────────────────────────────────

class _MobileGranularidadeDropdown extends StatelessWidget {
  final Granularidade? valor;
  final ValueChanged<Granularidade?> onChanged;

  const _MobileGranularidadeDropdown({
    required this.valor,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color:
              valor != null ? const Color(0xFF1B2A4A) : const Color(0xFFE8ECF0),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<Granularidade>(
          value: valor,
          isExpanded: true,
          isDense: true,
          hint: const Row(
            children: [
              Icon(Icons.tune_rounded, size: 14, color: Color(0xFF6B7A99)),
              SizedBox(width: 6),
              Text('Agrupar por',
                  style: TextStyle(fontSize: 13, color: Color(0xFFB0BAD0))),
            ],
          ),
          icon: const Icon(Icons.keyboard_arrow_down_rounded,
              size: 16, color: Color(0xFF6B7A99)),
          borderRadius: BorderRadius.circular(8),
          style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Color(0xFF1B2A4A)),
          items: Granularidade.values.map((g) {
            return DropdownMenuItem(
              value: g,
              child: Row(
                children: [
                  Icon(_icone(g), size: 14, color: const Color(0xFF6B7A99)),
                  const SizedBox(width: 8),
                  Text(g.label),
                ],
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  IconData _icone(Granularidade g) => switch (g) {
        Granularidade.dia => Icons.today_outlined,
        Granularidade.semana => Icons.view_week_outlined,
        Granularidade.mes => Icons.calendar_month_outlined,
      };
}
