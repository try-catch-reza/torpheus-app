import 'package:flutter/services.dart';

/// Máscara automática para placas de veículos brasileiros.
///
/// - **Padrão Normal:**   ABC-1234  (3 letras + hífen + 4 dígitos)
/// - **Padrão Mercosul:** ABC1D23   (3 letras + 1 dígito + 1 letra + 2 dígitos)
///
/// A detecção é automática: se a 5ª posição (após o hífen) for uma letra,
/// o formato é tratado como Mercosul; caso contrário, como o padrão normal.
class PlacaInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Remove tudo que não seja letra ou número e coloca em maiúsculo
    final raw = newValue.text
        .replaceAll(RegExp(r'[^a-zA-Z0-9]'), '')
        .toUpperCase();

    if (raw.isEmpty) {
      return newValue.copyWith(text: '');
    }

    final buffer = StringBuffer();
    int selectionOffset = 0;
    final cursorPos = newValue.selection.end;

    for (int i = 0; i < raw.length && i < 7; i++) {
      final char = raw[i];

      // Posições 0-2: somente letras
      if (i < 3) {
        if (!RegExp(r'[A-Z]').hasMatch(char)) break;
        buffer.write(char);
      }

      // Posição 3: insere hífen, depois um dígito
      if (i == 3) {
        if (!RegExp(r'[0-9]').hasMatch(char)) break;
        buffer.write('-');
        buffer.write(char);
      }

      // Posição 4: detecta padrão
      // Mercosul → letra | Normal → dígito
      if (i == 4) {
        if (RegExp(r'[A-Z]').hasMatch(char)) {
          // Mercosul: remove o hífen já adicionado e reescreve sem ele
          final semHifen = buffer.toString().replaceAll('-', '');
          buffer.clear();
          buffer.write(semHifen);
          buffer.write(char);
        } else if (RegExp(r'[0-9]').hasMatch(char)) {
          buffer.write(char);
        } else {
          break;
        }
      }

      // Posições 5-6: somente dígitos (ambos os padrões)
      if (i >= 5) {
        if (!RegExp(r'[0-9]').hasMatch(char)) break;
        buffer.write(char);
      }
    }

    final formatted = buffer.toString();

    // Recalcula offset do cursor
    selectionOffset = formatted.length < (cursorPos + 1)
        ? formatted.length
        : cursorPos + (formatted.length - raw.length > 0 ? 1 : 0);

    selectionOffset = selectionOffset.clamp(0, formatted.length);

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: selectionOffset),
    );
  }
}

