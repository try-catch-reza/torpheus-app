import 'package:flutter/material.dart';

class LoginMobileHeader extends StatelessWidget {
  const LoginMobileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 36),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: const Color(0xFF253A60),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFF304D7A)),
            ),
            child: const Icon(
              Icons.build_rounded,
              color: Colors.white,
              size: 28,
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            'TORPHÉUS',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: 3,
              decoration: TextDecoration.none,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Gestão de Oficina Mecânica',
            style: TextStyle(
              fontSize: 11,
              color: Color(0xFF8FA3C0),
              letterSpacing: 1.2,
              decoration: TextDecoration.none,
            ),
          ),
        ],
      ),
    );
  }
}