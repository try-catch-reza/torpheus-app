import 'package:flutter/material.dart';

enum StatusOrdem {
  aberta(1, 'Aberta'),
  emProgresso(2, 'Em progresso'),
  cancelado(3, 'Cancelado'),
  completado(4, 'Completado');

  final int value;
  final String label;

  const StatusOrdem(this.value, this.label);

  static StatusOrdem fromValues(int value) {
    return StatusOrdem.values.firstWhere((e) => e.value == value, orElse: () {
      throw ArgumentError('Valor inválido para StatusOrdem: $value');
    });
  }

  Color get colorStatus {
    switch (this) {
      case StatusOrdem.aberta:
        return Colors.blue.shade600;       // aberto: azul visível e neutro
      case StatusOrdem.emProgresso:
        return Colors.orange.shade600;     // em progresso: laranja para atenção
      case StatusOrdem.cancelado:
        return Colors.red.shade700;        // cancelado: vermelho mais forte
      case StatusOrdem.completado:
        return Colors.green.shade600;
    }
  }
}
