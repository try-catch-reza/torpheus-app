import 'package:flutter/material.dart';

class RecuperarSenhaDicas extends StatelessWidget {
  const RecuperarSenhaDicas({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 420),
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 32),
      decoration: BoxDecoration(
        color: const Color(0xFF253A60),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF304D7A)),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.lock_reset_rounded,
            color: Colors.white,
            size: 52,
          ),
          const SizedBox(height: 16),
          const Text(
            'Recuperação de senha',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              decoration: TextDecoration.none,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Enviaremos um link seguro para o e-mail cadastrado na sua conta.',
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF8FA3C0),
              height: 1.5,
              decoration: TextDecoration.none,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          // Steps visuais
          _buildStep(Icons.mail_outline_rounded, '1. Informe seu e-mail'),
          const SizedBox(height: 10),
          _buildStep(Icons.inbox_rounded, '2. Verifique sua caixa de entrada'),
          const SizedBox(height: 10),
          _buildStep(Icons.lock_open_rounded, '3. Crie uma nova senha'),
        ],
      ),
    );
  }

  Widget _buildStep(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF8FA3C0), size: 16),
        const SizedBox(width: 10),
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.white,
            fontWeight: FontWeight.w500,
            decoration: TextDecoration.none,
          ),
        ),
      ],
    );
  }
}