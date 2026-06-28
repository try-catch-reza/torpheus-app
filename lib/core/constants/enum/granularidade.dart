enum Granularidade {
  dia(1, 'Dia'),
  semana(2, 'Semana'),
  mes(3, 'Mês'),
  ;

  final int value;
  final String label;

  const Granularidade(this.value, this.label);

  static Granularidade fromValue(int value) {
    return Granularidade.values
        .firstWhere((e) => e.value == value, orElse: () => Granularidade.dia);
  }
}
