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
        return Colors.yellowAccent;
      case StatusOrdem.emProgresso:
        return Colors.amber;
      case StatusOrdem.cancelado:
        return Colors.redAccent;
      case StatusOrdem.completado:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
