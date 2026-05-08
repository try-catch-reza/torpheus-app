import 'package:flutter/material.dart';

class RecuperarSenhaWebHeader extends StatelessWidget {
  const RecuperarSenhaWebHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            color: const Color(0xFF253A60),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFF304D7A)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: const Icon(
            Icons.build_rounded,
            color: Colors.white,
            size: 34,
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'TORPHÉUS',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: Colors.white,
            letterSpacing: 4,
            decoration: TextDecoration.none,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Sistema de Gestão de Oficina Mecânica',
          style: TextStyle(
            fontSize: 13,
            color: Color(0xFF8FA3C0),
            letterSpacing: 1.5,
            decoration: TextDecoration.none,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}