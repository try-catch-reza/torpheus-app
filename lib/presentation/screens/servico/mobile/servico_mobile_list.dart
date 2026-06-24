import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:torpheus/core/constants/enum/status_servico.dart';

import '../../../../core/constants/color_constants.dart';
import '../../../../data/models/servico_model.dart';
import '../../../components/divider_custom.dart';

class ServicoMobileList extends StatelessWidget {
  const ServicoMobileList({
    super.key,
    required this.servicos,
    required this.onConcluir,
    required this.onUpdate,
    required this.onReabrir,
  });

  final List<ServicoModel> servicos;
  final ValueChanged<ServicoModel>? onConcluir;
  final ValueChanged<ServicoModel>? onUpdate;
  final ValueChanged<ServicoModel>? onReabrir;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: ColorConstants.mercury, width: 2.0),
        color: Colors.white,
      ),
      child: ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: servicos.length,
        separatorBuilder: (context, index) => DividerCustom.dividerList,
        itemBuilder: (context, index) {
          final servico = servicos[index];

          return Slidable(
            key: ValueKey(servico.id ?? index),
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                Visibility(
                  visible: servico.statusServico != StatusServico.completado,
                  child: SlidableAction(
                    padding: EdgeInsets.zero,
                    onPressed:
                        onUpdate != null ? (_) => onUpdate!(servico) : null,
                    backgroundColor: ColorConstants.chambray,
                    foregroundColor: Colors.white,
                    icon: Icons.edit,
                    label: 'Atualizar',
                  ),
                ),
                Visibility(
                  visible: servico.statusServico != StatusServico.completado,
                  child: SlidableAction(
                    padding: EdgeInsets.zero,
                    onPressed:
                        onConcluir != null ? (_) => onConcluir!(servico) : null,
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    icon: Icons.check_circle,
                    label: 'Concluir',
                  ),
                ),
                Visibility(
                  visible: servico.statusServico == StatusServico.completado,
                  child: SlidableAction(
                    padding: EdgeInsets.zero,
                    onPressed:
                        onReabrir != null ? (_) => onReabrir!(servico) : null,
                    backgroundColor: ColorConstants.chambray,
                    foregroundColor: Colors.white,
                    icon: Icons.lock_open_sharp,
                    label: 'Reabrir',
                  ),
                ),
              ],
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              dense: true,
              title: Text(
                servico.descricao ?? '',
                style: const TextStyle(
                  color: ColorConstants.steel,
                  fontSize: 15,
                ),
              ),
              subtitle: Text(
                servico.funcionarioId ?? 'Nenhum funcionário atribuído',
              ),
              trailing: SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: Row(
                  children: [
                    Icon(
                      Icons.circle,
                      color: servico.statusServico?.color,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      servico.statusServico?.label ?? '',
                      style: const TextStyle(
                        color: ColorConstants.chromaphobicBlack,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
