enum CombustivelVeiculo {
  gasoline(1, 'Gasolina'),
  ethanol(2, 'Etanol'),
  diesel(3, 'Diesel'),
  cng(4, 'GNV'),
  electric(5, 'Elétrico'),
  hybrid(6, 'Híbrido'),
  flex(7, 'Flex');

  final int value;
  final String label;

  const CombustivelVeiculo(this.value, this.label);

  static CombustivelVeiculo fromValue(int value) {
    return CombustivelVeiculo.values.firstWhere((e) => e.value == value, orElse: () {
      throw ArgumentError('Valor inválido para CombustivelVeiculo: $value');
    });
  }
}
