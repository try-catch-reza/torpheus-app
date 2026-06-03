import 'package:flutter/material.dart';

class FuncionarioDetalheWebHeader extends StatelessWidget {
  const FuncionarioDetalheWebHeader({
    super.key,
    required this.nomeFuncionario,
    required this.onVoltar,
  });

  final String nomeFuncionario;
  final VoidCallback onVoltar;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onVoltar,
          child: const Icon(
            Icons.chevron_left_rounded,
            size: 18,
            color: Color(0xFF6B7A99),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          nomeFuncionario,
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

