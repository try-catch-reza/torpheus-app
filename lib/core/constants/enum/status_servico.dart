enum StatusServico {
  esperandoMecanico(1),
  esperandoPeca(2),
  emProgresso(3),
  bloqueado(4),
  cancelado(5),
  completado(6);

  final int value;

  const StatusServico(this.value);

  static StatusServico fromValues(int value) {
    return StatusServico.values.firstWhere((e) => e.value == value, orElse: () {
      throw ArgumentError('Valor inválido para StatusOrdem: $value');
    });
  }
}
