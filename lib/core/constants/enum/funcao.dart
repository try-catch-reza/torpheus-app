enum Funcao {
  mecanico(1, 'Mecânico');

  final int value;
  final String label;

  const Funcao(this.value, this.label);

  static Funcao fromValue(int value) {
    return Funcao.values.firstWhere((e) => e.value == value, orElse: () {
      throw ArgumentError('Valor inválido para Funcao: $value');
    });
  }
}
