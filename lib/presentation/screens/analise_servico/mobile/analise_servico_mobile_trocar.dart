import 'package:flutter/material.dart';
import 'package:torpheus/core/constants/enum/status_servico.dart';

class AnaliseServicoMobileTrocar extends StatelessWidget {
  const AnaliseServicoMobileTrocar({
    super.key,
    required this.statusServico,
    required this.onPressed,
  });

  final StatusServico? statusServico;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Visibility(
        visible: statusServico != StatusServico.completado ||
            statusServico != StatusServico.cancelado,
        child: ElevatedButton.icon(
          onPressed: onPressed,
          label: const Text('Trocar funcionário'),
          icon: const Icon(Icons.person),
        ),
      ),
    );
  }
}
