import 'package:flutter/material.dart';
import 'package:torpheus/core/constants/enum/status_ordem.dart';
import 'package:torpheus/core/constants/extension/string_extension.dart';
import 'package:torpheus/data/models/ordem_servico_model.dart';
import 'package:torpheus/data/models/vis/vis_ordem_servico.dart';

import '../../../../core/constants/color_constants.dart';

class OrdensServicoWebTable extends StatelessWidget {
  const OrdensServicoWebTable({
    super.key,
    required this.ordens,
    required this.onTap,
  });

  final List<OrdemServicoModel> ordens;
  final ValueChanged<OrdemServicoModel>? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFEEEEEA), width: 0.5),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          _TableHeader(),
          const Divider(height: 1, thickness: 0.5, color: Color(0xFFEEEEEA)),
          Expanded(
            child: ListView.separated(
              itemCount: ordens.length,
              separatorBuilder: (_, __) => const Divider(
                height: 1,
                thickness: 0.5,
                color: Color(0xFFEEEEEA),
              ),
              itemBuilder: (context, i) {
                final ordem = ordens[i];

                return _TableRow(
                  ordem: ordem,
                  onTap: onTap != null ? () => onTap!(ordem) : null,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _TableHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Row(
        children: [
          _HeaderCell('OS', flex: 2),
          _HeaderCell('Placa/Modelo', flex: 2),
          _HeaderCell('Cliente', flex: 3),
          _HeaderCell('Serviços', flex: 2),
          _HeaderCell('Entrada', flex: 2),
          _HeaderCell('Mecânico', flex: 2),
          _HeaderCell('Status', flex: 2),
          SizedBox(width: 32),
        ],
      ),
    );
  }
}

class _HeaderCell extends StatelessWidget {
  const _HeaderCell(this.label, {required this.flex});

  final String label;
  final int flex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Text(
        label.toUpperCase(),
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: Color(0xFF9A9A96),
          letterSpacing: 0.6,
        ),
      ),
    );
  }
}

class _TableRow extends StatefulWidget {
  const _TableRow({required this.ordem, required this.onTap});

  final OrdemServicoModel ordem;
  final VoidCallback? onTap;

  @override
  State<_TableRow> createState() => _TableRowState();
}

class _TableRowState extends State<_TableRow> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          color: _hovered ? const Color(0xFFF7F7F5) : Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  widget.ordem.id ?? '',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: ColorConstants.chambray,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'LZW-2704 / Corsa Wind',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF3A3A38),
                  ),
                ),
              ),
              // Modelo / Ano
              Expanded(
                flex: 3,
                child: Text(
                  'Cleiton',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF1A1A18),
                  ),
                ),
              ),
              // Combustível
              Expanded(
                flex: 2,
                child: Text(
                  widget.ordem.quantidadeServico.toString(),
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF3A3A38),
                  ),
                ),
              ),
              // Câmbio
              Expanded(
                flex: 2,
                child: Text(
                  widget.ordem.dataCriacao.toString().formataData,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF3A3A38),
                  ),
                ),
              ),
              // Tipo
              Expanded(
                flex: 2,
                child: Text(
                  'Mecânico',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF3A3A38),
                  ),
                ),
              ),
              // Status
              Expanded(
                flex: 2,
                child: _StatusBadge(status: widget.ordem.statusOrdem!),
              ),
              // Chevron
              Visibility(
                visible: widget.onTap != null,
                child: Icon(
                  Icons.chevron_right_rounded,
                  size: 20,
                  color: _hovered
                      ? ColorConstants.chambray
                      : const Color(0xFFBBBBB7),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});

  final StatusOrdem status;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: status.colorStatus,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          status.label,
          style: TextStyle(
            fontSize: 13,
            color: status.colorStatus,
          ),
        ),
      ],
    );
  }
}
