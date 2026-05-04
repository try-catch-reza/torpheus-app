extension StringExtension on String {
  /// Gera as iniciais a partir do nome completo.
  /// "Juliana Prado" → "JP"
  String get iniciais {
    final partes = trim().split(' ');
    if (partes.length >= 2) {
      return '${partes.first[0]}${partes.last[0]}'.toUpperCase();
    }
    return partes.first
        .substring(0, partes.first.length.clamp(0, 2))
        .toUpperCase();
  }
}