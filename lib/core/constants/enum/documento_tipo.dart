enum DocumentoTipo {
  cpf(1, 'CPF'),
  cpnj(2, 'CNPJ');

  final int value;
  final String label;

  const DocumentoTipo(this.value, this.label);

  static DocumentoTipo fromValue(int value) {
    return DocumentoTipo.values.firstWhere((e) => e.value == value, orElse: () {
      throw ArgumentError('Valor inválido para DocumentoTipo: $value');
    });
  }
}
