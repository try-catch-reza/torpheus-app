import 'package:intl/intl.dart';

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

  String get primeiraLetraMaiuscula {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  String get formataData {
    if(isEmpty) return '';

    if(contains(' ')) {
      DateTime tempDate = DateFormat('yyyy-MM-dd HH:mm:ss').parse(this);
      String date = DateFormat("dd/MM/yyyy").format(tempDate);
      return date;
    }
    if(contains('T')) {
      DateTime tempDate = DateFormat('yyyy-MM-ddTHH:mm').parse(this);
      String date = DateFormat("dd/MM/yyyy").format(tempDate);
      return date;
    }

    return this;
  }

}