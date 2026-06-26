import 'package:flutter/material.dart';
import 'package:torpheus/presentation/screens/servico/web/servico_web_descr.dart';
import 'package:torpheus/presentation/screens/servico/web/servico_web_pop_up.dart';
import 'package:torpheus/presentation/screens/servico/web/servico_web_status.dart';

import '../../../../data/models/servico_model.dart';

class ServicoWebCard extends StatelessWidget {
  const ServicoWebCard({
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
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 16,
      ),
      child: Row(
        children: [
          ServicoWebDescr(servico: servico),
          ServicoWebStatus(servico: servico),
          const SizedBox(width: 8),
          ServicoWebPopUp(
            onConcluir: onConcluir,
            onUpdate: onUpdate,
            onReabrir: onReabrir,
            onAbrirFotos: onAbrirFotos,
            servico: servico,
          ),
        ],
      ),
    );
  }
}
