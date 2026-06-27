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
    required this.onCancelar,
    required this.servico,
  });

  final ValueChanged<ServicoModel>? onConcluir;
  final ValueChanged<ServicoModel>? onUpdate;
  final ValueChanged<ServicoModel>? onReabrir;
  final ValueChanged<ServicoModel>? onAbrirFotos;
  final ValueChanged<ServicoModel>? onCancelar;

  final ServicoModel servico;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert, color: Color(0xFF6B7A99)),
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
        } else if (value == 'cancelar') {
          onCancelar?.call(servico);
        }
      },
      itemBuilder: (_) {
        final isConcluido = servico.statusServico != StatusServico.completado &&
            servico.statusServico != StatusServico.cancelado;

        final podeCancelar =
            servico.statusServico == StatusServico.emProgresso ||
                servico.statusServico == StatusServico.esperandoMecanico;

        final isEditar = servico.statusServico != StatusServico.completado &&
            servico.statusServico != StatusServico.cancelado;

        return [
          if (isEditar)
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
          if (isConcluido)
            const PopupMenuItem(
              value: 'concluir',
              height: 40,
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle_outline_rounded,
                    size: 16,
                    color: Color(
                      0xFF12B76A,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Concluir',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF12B76A),
                    ),
                  ),
                ],
              ),
            ),
          if (podeCancelar)
            const PopupMenuItem(
              value: 'cancelar',
              height: 40,
              child: Row(
                children: [
                  Icon(Icons.cancel_outlined,
                      size: 16, color: Color(0xFFD92D20)),
                  SizedBox(width: 10),
                  Text(
                    'Cancelar',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFD92D20),
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
