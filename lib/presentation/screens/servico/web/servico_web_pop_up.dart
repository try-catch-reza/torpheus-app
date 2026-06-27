import 'package:flutter/material.dart';

import '../../../../core/constants/enum/status_servico.dart';
import '../../../../data/models/servico_model.dart';

class ServicoWebPopUp extends StatelessWidget {
  const ServicoWebPopUp({
    super.key,
    required this.onConcluir,
    required this.onUpdate,
    required this.onReabrir,
    required this.onAbrirFotos,
    required this.servico,
  });

  final ValueChanged<ServicoModel>? onConcluir;
  final ValueChanged<ServicoModel>? onUpdate;
  final ValueChanged<ServicoModel>? onReabrir;
  final ValueChanged<ServicoModel>? onAbrirFotos;

  final ServicoModel servico;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(
        Icons.more_vert,
        color: Color(0xFF6B7A99),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: Color(0xFFE8ECF0)),
      ),
      elevation: 4,
      shadowColor: Colors.black12,
      position: PopupMenuPosition.under,
      onSelected: (value) {
        if (value == 'edit') {
          onUpdate?.call(servico);
        } else if (value == 'concluir') {
          onConcluir?.call(servico);
        } else if (value == 'reabrir') {
          onReabrir?.call(servico);
        } else if (value == 'fotos') {
          onAbrirFotos?.call(servico);
        }
      },
      itemBuilder: (_) {
        final isConcluido = servico.statusServico == StatusServico.completado;

        return [
          if (!isConcluido)
            const PopupMenuItem(
              value: 'edit',
              height: 40,
              child: Row(
                children: [
                  Icon(Icons.edit_outlined, size: 16, color: Color(0xFF344054)),
                  SizedBox(width: 10),
                  Text(
                    'Editar',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF344054),
                    ),
                  ),
                ],
              ),
            ),
          const PopupMenuItem(
            value: 'fotos',
            height: 40,
            child: Row(
              children: [
                Icon(
                  Icons.photo_library_outlined,
                  size: 16,
                  color: Color(0xFF6B7A99),
                ),
                SizedBox(width: 10),
                Text(
                  'Fotos',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF6B7A99),
                  ),
                ),
              ],
            ),
          ),
          if (!isConcluido)
            PopupMenuItem(
              value: 'concluir',
              height: 40,
              child: Row(
                children: [
                  const Icon(
                    Icons.check_circle_outline_rounded,
                    size: 16,
                    color: Color(0xFF12B76A),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Concluir',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color:
                          isConcluido ? Colors.white : const Color(0xFF12B76A),
                    ),
                  ),
                ],
              ),
            ),
        ];
      },
    );
  }
}
