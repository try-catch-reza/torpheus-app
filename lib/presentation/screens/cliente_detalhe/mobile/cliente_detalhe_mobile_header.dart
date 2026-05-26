import 'package:flutter/material.dart';

class ClienteDetalheMobileHeader extends StatelessWidget {
  const ClienteDetalheMobileHeader({
    super.key,
    required this.nomeCliente,
  });

  final String nomeCliente;

  @override
  Widget build(BuildContext context) {
    return Text(
      nomeCliente,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: Color(0xFF1B2A4A),
        decoration: TextDecoration.none,
      ),
    );
  }
}
