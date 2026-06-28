import 'package:flutter/material.dart';
import 'package:torpheus/core/constants/enum/status_ordem.dart';
import 'package:torpheus/presentation/screens/servico/web/servico_web_card.dart';
import 'package:torpheus/presentation/screens/servico/web/servico_web_title_list.dart';

import '../../../../data/models/servico_model.dart';

class ServicoWebList extends StatelessWidget {
  const ServicoWebList({
    super.key,
    required this.servicos,
    required this.onPressed,
    required this.onConcluir,
    required this.onUpdate,
    required this.onReabrir,
    required this.onAbrirFotos,
    required this.onCancelar,
    required this.onAnalisarServico,
    required this.statusOrdem,
  });

  final List<ServicoModel> servicos;
  final VoidCallback onPressed;
  final ValueChanged<ServicoModel>? onConcluir;
  final ValueChanged<ServicoModel>? onUpdate;
  final ValueChanged<ServicoModel>? onReabrir;
  final ValueChanged<ServicoModel>? onAbrirFotos;
  final ValueChanged<ServicoModel>? onCancelar;
  final ValueChanged<ServicoModel>? onAnalisarServico;
  final StatusOrdem? statusOrdem;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE8ECF0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ServicoWebTitleList(
            onPressed: onPressed,
            quantServicos: servicos.length,
            statusOrdem: statusOrdem,
          ),
          const Divider(height: 1, thickness: 1, color: Color(0xFFEEF0F3)),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: servicos.length,
            separatorBuilder: (_, __) => const Divider(
              height: 1,
              thickness: 1,
              color: Color(0xFFEEF0F3),
            ),
            itemBuilder: (context, index) {
              final servico = servicos[index];

              return ServicoWebCard(
                onConcluir: onConcluir,
                onUpdate: onUpdate,
                onReabrir: onReabrir,
                onAbrirFotos: onAbrirFotos,
                onCancelar: onCancelar,
                onAnalisarServico: onAnalisarServico,
                servico: servico,
              );
            },
          ),
        ],
      ),
    );
  }
}
