import 'package:flutter/material.dart';
import 'package:torpheus/core/constants/enum/documento_tipo.dart';

class CadastrarClienteWebTipoDocumento extends StatelessWidget {
  const CadastrarClienteWebTipoDocumento({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  final DocumentoTipo selected;
  final ValueChanged<DocumentoTipo> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      decoration: BoxDecoration(
        color: const Color(0xFFE8ECF4),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          _ToggleOption(
            label: 'CPF',
            isSelected: selected == DocumentoTipo.cpf,
            onTap: () => onChanged(DocumentoTipo.cpf),
          ),
          _ToggleOption(
            label: 'CNPJ',
            isSelected: selected == DocumentoTipo.cpnj,
            onTap: () => onChanged(DocumentoTipo.cpnj),
          ),
        ],
      ),
    );
  }
}

class _ToggleOption extends StatelessWidget {
  const _ToggleOption({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 42,
          margin: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.07),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected
                    ? const Color(0xFF1B2A4A)
                    : const Color(0xFF9BAABB),
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
