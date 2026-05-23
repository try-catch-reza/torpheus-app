import 'package:flutter/material.dart';

class ClienteWebTableHeader extends StatelessWidget {
  const ClienteWebTableHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFFEAEDF2)),
        ),
      ),
      child: const Row(
        children: [
          Expanded(
            flex: 4,
            child: ClienteWebHeaderCell('CLIENTE'),
          ),
          Expanded(
            flex: 3,
            child: ClienteWebHeaderCell('CPF'),
          ),
          Expanded(
            flex: 3,
            child: ClienteWebHeaderCell('TELEFONE'),
          ),
          Expanded(
            flex: 4,
            child: ClienteWebHeaderCell('E-MAIL'),
          ),
          Expanded(
            flex: 2,
            child: ClienteWebHeaderCell('VEÍCULOS'),
          ),
          SizedBox(width: 32),
        ],
      ),
    );
  }
}

class ClienteWebHeaderCell extends StatelessWidget {
  const ClienteWebHeaderCell(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: Color(0xFF9BAABB),
        letterSpacing: 0.6,
        decoration: TextDecoration.none,
      ),
    );
  }
}
