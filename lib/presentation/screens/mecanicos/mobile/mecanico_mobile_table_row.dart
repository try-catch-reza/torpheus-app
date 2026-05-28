import 'package:flutter/material.dart';

import '../../../../data/models/mecanico_model.dart';

class MecanicoMobileTableRow extends StatelessWidget {
  const MecanicoMobileTableRow({
    super.key,
    required this.mecanico,
    required this.showDivider,
    required this.onTap,
  });

  final MecanicoModel mecanico;
  final bool showDivider;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            color: Colors.transparent,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Row(
                    children: [
                      _Avatar(iniciais: mecanico.iniciais),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          mecanico.nome ?? '',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1B2A4A),
                            decoration: TextDecoration.none,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 32,
                  child: Icon(
                    Icons.chevron_right_rounded,
                    size: 18,
                    color: Color(0xFFCDD3DE),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (showDivider) const Divider(height: 1, color: Color(0xFFF0F2F5)),
      ],
    );
  }
}


// ── Avatar ────────────────────────────────────────────────────────────────────

class _Avatar extends StatelessWidget {
  const _Avatar({required this.iniciais});

  final String iniciais;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: const Color(0xFFE8ECF4),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          iniciais,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1B2A4A),
            decoration: TextDecoration.none,
          ),
        ),
      ),
    );
  }
}

// ── Célula de texto ───────────────────────────────────────────────────────────

class _RowCell extends StatelessWidget {
  const _RowCell(this.value);

  final String value;

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: const TextStyle(
        fontSize: 13,
        color: Color(0xFF6B7A99),
        decoration: TextDecoration.none,
      ),
      overflow: TextOverflow.ellipsis,
    );
  }
}
