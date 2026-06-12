import 'package:flutter/material.dart';

import '../../../../core/constants/color_constants.dart';
import '../../../../data/models/veiculo_model.dart';

class VeiculoWebTable extends StatelessWidget {
  const VeiculoWebTable({
    super.key,
    required this.veiculos,
    required this.onTap,
  });

  final List<VeiculoModel> veiculos;
  final ValueChanged<VeiculoModel>? onTap;

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
              itemCount: veiculos.length,
              separatorBuilder: (_, __) => const Divider(
                height: 1,
                thickness: 0.5,
                color: Color(0xFFEEEEEA),
              ),
              itemBuilder: (context, i) {
                final veiculo = veiculos[i];
            
                return _TableRow(
                  veiculo: veiculo,
                  onTap: onTap != null ? () => onTap!(veiculos[i]) : null,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ── Cabeçalho ─────────────────────────────────────────────────────────────────

class _TableHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Row(
        children: [
          _HeaderCell('Placa', flex: 2),
          _HeaderCell('Marca', flex: 2),
          _HeaderCell('Modelo / Ano', flex: 3),
          _HeaderCell('Combustível', flex: 2),
          _HeaderCell('Câmbio', flex: 2),
          _HeaderCell('Tipo', flex: 2),
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

// ── Linha ─────────────────────────────────────────────────────────────────────

class _TableRow extends StatefulWidget {
  const _TableRow({required this.veiculo, required this.onTap});

  final VeiculoModel veiculo;
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
              // Placa
              Expanded(
                flex: 2,
                child: Text(
                  widget.veiculo.placa ?? '—',
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
                  widget.veiculo.marca?.label ?? '—',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF3A3A38),
                  ),
                ),
              ),
              // Modelo / Ano
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _modeloCompleto,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF1A1A18),
                      ),
                    ),
                    if (widget.veiculo.ano != null)
                      Text(
                        widget.veiculo.ano.toString(),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF9A9A96),
                        ),
                      ),
                  ],
                ),
              ),
              // Combustível
              Expanded(
                flex: 2,
                child: Text(
                  widget.veiculo.combustivel?.label ?? '',
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
                  widget.veiculo.cambio?.label ?? '',
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
                  widget.veiculo.tipo?.label ?? '',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF3A3A38),
                  ),
                ),
              ),
              // Status
              Expanded(
                flex: 2,
                child: _StatusBadge(ativo: widget.veiculo.isActive ?? false),
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

  String get _modeloCompleto {
    final partes = [
      widget.veiculo.marca,
      widget.veiculo.modelo,
    ].whereType<String>().toList();
    return partes.isNotEmpty ? partes.join(' ') : '—';
  }
}

// ── Badge de status ───────────────────────────────────────────────────────────

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.ativo});

  final bool ativo;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ativo ? const Color(0xFF1D9E75) : const Color(0xFFB4B2A9),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          ativo ? 'Ativo' : 'Inativo',
          style: TextStyle(
            fontSize: 13,
            color: ativo ? const Color(0xFF085041) : const Color(0xFF6B6B67),
          ),
        ),
      ],
    );
  }
}
