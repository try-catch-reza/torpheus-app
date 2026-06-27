import 'package:flutter/material.dart';

enum StatusServico {
  esperandoMecanico(1, 'Esperando mecânico'),
  emProgresso(3, 'Em progresso'),
  cancelado(5, 'Cancelado'),
  completado(6, 'Completado');

  final int value;
  final String label;

  const StatusServico(this.value, this.label);

  static StatusServico fromValues(int value) {
    return StatusServico.values.firstWhere((e) => e.value == value, orElse: () {
      throw ArgumentError('Valor inválido para StatusServico: $value');
    });
  }

  /// Cor de fundo representando o status.
  Color get color {
    switch (this) {
      case StatusServico.esperandoMecanico:
        return Colors.amber.shade400;
      case StatusServico.emProgresso:
        return Colors.orange.shade600;
      case StatusServico.cancelado:
        return Colors.red.shade700;
      case StatusServico.completado:
        return Colors.green.shade600;
    }
  }

  /// Cor do texto adequada ao contraste com a cor de fundo.
  Color get textColor {
    final bg = color;
    return bg.computeLuminance() > 0.5 ? Colors.black : Colors.white;
  }

  @override
  String toString() => label;
}
