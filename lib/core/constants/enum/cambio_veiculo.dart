enum CambioVeiculo {
  manual(1, 'Manual'),
  automatico(2, 'Automático'),
  cvt(3, 'CVT'),
  automatizado(4, 'Automatizado');

  final int value;
  final String label;

  const CambioVeiculo(this.value, this.label);

  static CambioVeiculo fromValue(int value) {
    return CambioVeiculo.values.firstWhere((e) => e.value == value, orElse: () {
      throw ArgumentError('Valor inválido para CambioVeiculo: $value');
    });
  }
}