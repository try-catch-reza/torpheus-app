import 'package:flutter/material.dart';

import '../../../../data/models/cliente_model.dart';
import '../../../components/avatar.dart';

class ClienteMobileTableRow extends StatelessWidget {
  const ClienteMobileTableRow({
    super.key,
    required this.cliente,
    required this.showDivider,
    required this.onTap,
  });

  final ClienteModel cliente;
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
                      Avatar(iniciais: cliente.iniciais),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          cliente.nome ?? '',
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
