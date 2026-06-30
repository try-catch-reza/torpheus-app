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
    required this.onCancelar,
    required this.onAbrirCamera,
    required this.onAnalisarServico,
    required this.hasPodeGerenciaFoto,
  });

  final List<ServicoModel> servicos;
  final ValueChanged<ServicoModel>? onConcluir;
  final ValueChanged<ServicoModel>? onCancelar;
  final ValueChanged<ServicoModel>? onUpdate;
  final ValueChanged<ServicoModel>? onAbrirCamera;
  final ValueChanged<ServicoModel>? onAnalisarServico;
  final bool hasPodeGerenciaFoto;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: ColorConstants.mercury, width: 2.0),
        color: Colors.white,
      ),
      child: ListView.separated(
        padding: EdgeInsets.zero,
        itemCount: servicos.length,
        separatorBuilder: (context, index) => DividerCustom.dividerList,
        itemBuilder: (context, index) {
          final servico = servicos[index];

          return Container(
            decoration: BoxDecoration(
              border: Border(
                top: const BorderSide(
                  color: ColorConstants.mercury,
                  width: 1.0,
                ),
                bottom: const BorderSide(
                  color: ColorConstants.mercury,
                  width: 1.0,
                ),
                left: BorderSide(
                  color: servico.statusServico?.color ?? ColorConstants.mercury,
                  width: 5.0,
                ),
              ),
            ),
            child: Slidable(
              key: ValueKey(servico.id ?? index),
              endActionPane: ActionPane(
                extentRatio: 1,
                motion: const ScrollMotion(),
                children: [
                  Visibility(
                    visible:
                        servico.statusServico != StatusServico.completado &&
                            servico.statusServico != StatusServico.cancelado,
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
                    visible: hasPodeGerenciaFoto,
                    child: SlidableAction(
                      padding: EdgeInsets.zero,
                      onPressed: onAbrirCamera != null
                          ? (_) => onAbrirCamera!(servico)
                          : null,
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      icon: Icons.photo_camera,
                      label: 'Galeria',
                    ),
                  ),
                  Visibility(
                    visible:
                        servico.statusServico != StatusServico.completado &&
                            servico.statusServico != StatusServico.cancelado,
                    child: SlidableAction(
                      padding: EdgeInsets.zero,
                      onPressed: onConcluir != null
                          ? (_) => onConcluir!(servico)
                          : null,
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      icon: Icons.check_circle,
                      label: 'Concluir',
                    ),
                  ),
                  Visibility(
                    visible:
                        servico.statusServico == StatusServico.emProgresso ||
                            servico.statusServico ==
                                StatusServico.esperandoMecanico,
                    child: SlidableAction(
                      padding: EdgeInsets.zero,
                      onPressed: onCancelar != null
                          ? (_) => onCancelar!(servico)
                          : null,
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      icon: Icons.clear,
                      label: 'Cancelar',
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
                onTap: onAnalisarServico != null
                    ? () => onAnalisarServico!(servico)
                    : null,
                title: Text(
                  servico.descricao ?? '',
                  style: const TextStyle(
                    color: ColorConstants.steel,
                    fontSize: 15,
                  ),
                ),
                subtitle: Text(
                  servico.funcionarioNome ?? 'Nenhum funcionário atribuído',
                ),
                trailing: const Icon(
                  Icons.chevron_right,
                  color: ColorConstants.steel,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
