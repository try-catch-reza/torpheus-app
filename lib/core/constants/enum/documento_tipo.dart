enum DocumentoTipo {
  cpf(1),
  cpnj(2);

  final int value;

  const DocumentoTipo(this.value);

  DocumentoTipo fromValue(int value) {
    return DocumentoTipo.values.firstWhere((e) => e.value == value, orElse: () {
      throw ArgumentError('Valor inválido para DocumentoTipo: $value');
    });
  }
}
