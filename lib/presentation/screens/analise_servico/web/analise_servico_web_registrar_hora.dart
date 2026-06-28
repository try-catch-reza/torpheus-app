import 'package:flutter/material.dart';
import 'package:torpheus/core/constants/color_constants.dart';
import 'package:torpheus/data/models/funcionario_model.dart';
import 'package:torpheus/presentation/components/app_dropdown_field.dart';
import 'package:torpheus/presentation/components/app_text_field.dart';
import 'package:torpheus/presentation/screens/analise_servico/bloc/analise_servico_bloc.dart';

class AnaliseServicoWebRegistrarHora extends StatelessWidget {
  const AnaliseServicoWebRegistrarHora({
    super.key,
    required this.horaController,
    required this.minutoController,
    required this.notaController,
    required this.state,
  });

  final TextEditingController horaController;
  final TextEditingController minutoController;
  final TextEditingController notaController;
  final AnaliseServicoState state;

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
          _Header(),
          SizedBox(height: 20),
          _FormSection(funcionario: state.funcionario),
          SizedBox(height: 16),
          _Divider(),
          SizedBox(height: 16),
          _TabelaLancamentos(),
        ],
      ),
    );
  }
}

// ── Header ────────────────────────────────────────────────────────────────────

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Icon(Icons.access_time_rounded, size: 18, color: Color(0xFF6B7A99)),
        SizedBox(width: 8),
        Text(
          'Horas de trabalho',
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1B2A4A)),
        ),
      ],
    );
  }
}

// ── Formulário ────────────────────────────────────────────────────────────────

class _FormSection extends StatelessWidget {
  const _FormSection({required this.funcionario});

  final FuncionarioModel? funcionario;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Mecânico
            Expanded(
              flex: 4,
              child: _FormField(
                label: 'Funcionário',
                child: Container(
                  height: 42,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFE8ECF0)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Expanded(
                    child: Text(
                      funcionario?.nome ?? '',
                      style: const TextStyle(
                          fontSize: 13, color: Color(0xFF1B2A4A)),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Data
            Expanded(
              flex: 3,
              child: _FormField(
                label: 'DATA',
                child: _InputBox(
                  hint: 'dd/mm/aaaa',
                  trailing: Icons.calendar_today_outlined,
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Horas
            Expanded(
              flex: 2,
              child: _FormField(label: 'HORAS', child: _InputBox(hint: '0')),
            ),
            const SizedBox(width: 12),
            // Min
            Expanded(
              flex: 2,
              child: _FormField(label: 'MIN', child: _InputBox(hint: '0')),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Textarea
        _FormField(
          label: 'O QUE FOI FEITO',
          child: Container(
            height: 80,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFE8ECF0)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Descreva o trabalho realizado neste período...',
                style: TextStyle(fontSize: 13, color: Color(0xFFB0BAD0)),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Informe horas e/ou minutos',
              style: TextStyle(fontSize: 12, color: Color(0xFF6B7A99)),
            ),
            ElevatedButton.icon(
              onPressed: null, // desabilitado enquanto sem dados
              icon: const Icon(Icons.add, size: 16),
              label: const Text('Registrar horas'),
              style: ElevatedButton.styleFrom(
                disabledBackgroundColor: const Color(0xFFE8ECF0),
                disabledForegroundColor: const Color(0xFF6B7A99),
                textStyle:
                    const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _FormField extends StatelessWidget {
  final String label;
  final Widget child;

  const _FormField({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Color(0xFF6B7A99),
            letterSpacing: 0.6,
          ),
        ),
        const SizedBox(height: 6),
        child,
      ],
    );
  }
}

class _InputBox extends StatelessWidget {
  final String hint;
  final IconData? trailing;

  const _InputBox({required this.hint, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE8ECF0)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              hint,
              style: const TextStyle(fontSize: 13, color: Color(0xFFB0BAD0)),
            ),
          ),
          if (trailing != null)
            Icon(trailing, size: 16, color: const Color(0xFF6B7A99)),
        ],
      ),
    );
  }
}

// ── Divider ───────────────────────────────────────────────────────────────────

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return const Divider(height: 1, thickness: 1, color: Color(0xFFEEF0F3));
  }
}

// ── Tabela de lançamentos ─────────────────────────────────────────────────────

class _TabelaLancamentos extends StatelessWidget {
  const _TabelaLancamentos();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _TabelaHeader(),
        SizedBox(height: 12),
        _Divider(),
        SizedBox(height: 12),
        _TabelaRow(
          mecanico: 'Lucas Ferreira',
          data: '24/04 08:30',
          duracao: '25min',
          oQueFoiFeito:
              'Inspeção visual completa, teste de freio em bancada e análise do óleo.',
        ),
        SizedBox(height: 12),
        _Divider(),
        SizedBox(height: 12),
        _TabelaTotal(total: '25min', estimado: 'Estimado: 30min'),
      ],
    );
  }
}

class _TabelaHeader extends StatelessWidget {
  const _TabelaHeader();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(flex: 2, child: _ColLabel('MECÂNICO')),
        Expanded(flex: 2, child: _ColLabel('DATA')),
        Expanded(flex: 2, child: _ColLabel('DURAÇÃO')),
        Expanded(flex: 5, child: _ColLabel('O QUE FOI FEITO')),
      ],
    );
  }
}

class _ColLabel extends StatelessWidget {
  final String text;

  const _ColLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: Color(0xFF6B7A99),
        letterSpacing: 0.6,
      ),
    );
  }
}

class _TabelaRow extends StatelessWidget {
  final String mecanico;
  final String data;
  final String duracao;
  final String oQueFoiFeito;

  const _TabelaRow({
    required this.mecanico,
    required this.data,
    required this.duracao,
    required this.oQueFoiFeito,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            mecanico,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF2E90FA),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            data,
            style: const TextStyle(fontSize: 13, color: Color(0xFF1B2A4A)),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            duracao,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1B2A4A),
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Text(
            oQueFoiFeito,
            style: const TextStyle(fontSize: 13, color: Color(0xFF1B2A4A)),
          ),
        ),
      ],
    );
  }
}

class _TabelaTotal extends StatelessWidget {
  final String total;
  final String estimado;

  const _TabelaTotal({required this.total, required this.estimado});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(flex: 2, child: SizedBox()),
        const Expanded(
          flex: 2,
          child: Text(
            'TOTAL ACUMULADO',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: Color(0xFF6B7A99),
              letterSpacing: 0.6,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            total,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1B2A4A),
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Text(
            estimado,
            style: const TextStyle(fontSize: 13, color: Color(0xFF6B7A99)),
          ),
        ),
      ],
    );
  }
}
