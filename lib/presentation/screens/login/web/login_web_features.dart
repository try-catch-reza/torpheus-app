import 'package:flutter/material.dart';

class LoginWebFeatures extends StatelessWidget {
  const LoginWebFeatures({super.key});

  static const _features = [
    (Icons.receipt_long_rounded, 'Gestão completa de Ordens de Serviço'),
    (Icons.build_sharp, 'Histórico detalhado de veículos e clientes'),
    (Icons.groups_rounded, 'Controle de equipe e produtividade'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final (icon, label) in _features) ...[
          _FeatureItem(icon: icon, label: label),
          const SizedBox(height: 10),
        ],
      ],
    );
  }
}

class _FeatureItem extends StatelessWidget {
  const _FeatureItem({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 420),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF253A60),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF304D7A)),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF8FA3C0), size: 18),
          const SizedBox(width: 14),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}