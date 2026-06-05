enum TipoVeiculo {
  carro(1, 'Carro'),
  motocicleta(2, 'Motocicleta');

  final int value;
  final String label;

  const TipoVeiculo(this.value, this.label);

  static TipoVeiculo fromValue(int value) {
    return TipoVeiculo.values.firstWhere((e) => e.value == value, orElse: () {
      throw ArgumentError('Valor inválido para Funcao: $value');
    });
  }
}
