import 'package:flutter/material.dart';
import 'package:torpheus/core/constants/color_constants.dart';
import 'package:torpheus/data/models/ordem_servico_model.dart';

/// Header azul do dialog de detalhes da OS.
/// Exibe nome do cliente, descrição, placa + modelo e botão fechar.
class OrdemServicoWebHeader extends StatelessWidget {
  const OrdemServicoWebHeader({
    super.key,
    required this.ordem,
    required this.onFechar,
  });

  final OrdemServicoModel ordem;
  final VoidCallback onFechar;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 20, 16, 20),
      decoration: BoxDecoration(
        color: ColorConstants.chambray,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(14),
          topRight: Radius.circular(14),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ordem.clienteNome ?? '—',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  ordem.descricaoCliente ?? '—',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF8FA3C0),
                    decoration: TextDecoration.none,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFF253A60),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFF304D7A)),
                ),
                child: Text(
                  ordem.veiculoPlaca ?? '—',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 1,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
              if (ordem.veiculoModelo != null) ...[
                const SizedBox(height: 4),
                Text(
                  ordem.veiculoModelo!,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF8FA3C0),
                    decoration: TextDecoration.none,
                  ),
                ),
              ],
            ],
          ),

          const SizedBox(width: 4),

          // Fechar
          IconButton(
            onPressed: onFechar,
            icon: const Icon(Icons.close_rounded),
            color: const Color(0xFF8FA3C0),
            iconSize: 20,
            splashRadius: 18,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          ),
        ],
      ),
    );
  }
}
