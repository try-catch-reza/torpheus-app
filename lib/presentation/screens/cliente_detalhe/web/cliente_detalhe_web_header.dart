import 'package:flutter/material.dart';

class ClienteDetalheWebHeader extends StatelessWidget {
  const ClienteDetalheWebHeader({
    super.key,
    required this.nomeCliente,
    required this.onVoltar,
  });

  final String nomeCliente;
  final VoidCallback onVoltar;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onVoltar,
          child: Row(
            children: [
              const Icon(
                Icons.chevron_left_rounded,
                size: 18,
                color: Color(0xFF6B7A99),
              ),
              const SizedBox(width: 2),
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: const Color(0xFFDDE1EA)),
                ),
                child: const Text(
                  'Clientes',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF6B7A99),
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Text(
          nomeCliente,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1B2A4A),
            decoration: TextDecoration.none,
          ),
        ),
      ],
    );
  }
}