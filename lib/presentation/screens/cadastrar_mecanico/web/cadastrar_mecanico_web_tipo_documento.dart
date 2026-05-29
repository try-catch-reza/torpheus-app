import 'package:flutter/material.dart';
import 'package:torpheus/core/constants/enum/documento_tipo.dart';

class CadastrarMecanicoWebTipoDocumento extends StatelessWidget {
  const CadastrarMecanicoWebTipoDocumento({super.key, required this.selected, required this.onChanged});

  final DocumentoTipo selected;
  final ValueChanged<DocumentoTipo> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          'Tipo de documento',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: Color(0xFF9BAABB),
            decoration: TextDecoration.none,
          ),
        ),
        const SizedBox(width: 12),
        DropdownButton<DocumentoTipo>(
          value: selected,
          items: DocumentoTipo.values.map((e) => DropdownMenuItem(value: e, child: Text(e.name))).toList(),
          onChanged: (v) {
            if (v != null) onChanged(v);
          },
        ),
      ],
    );
  }
}
