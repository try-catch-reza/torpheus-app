import 'package:flutter/material.dart';
import 'package:torpheus/core/constants/enum/status_servico.dart';

import '../../../core/constants/color_constants.dart';

class DialogLegendaServicos extends StatelessWidget {
  const DialogLegendaServicos({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => const DialogLegendaServicos(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Legenda dos Status'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: StatusServico.values
            .map(
              (status) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  children: [
                    Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: status.color,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        status.label,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Fechar',
            style: TextStyle(color: ColorConstants.chambray),
          ),
        ),
      ],
    );
  }
}
