import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/core/constants/color_constants.dart';
import 'package:torpheus/data/models/perfis_model.dart';

import '../../../components/dialog/dialog_confirm.dart';
import '../bloc/perfis_bloc.dart';
import '../bloc/perfis_event.dart';
import '../bloc/perfis_state.dart';

class PerfisWebHeader extends StatelessWidget {
  const PerfisWebHeader({super.key, required this.perfis});

  final PerfisModel? perfis;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: ColorConstants.zhenZhuBaiPearl,
        border: Border(bottom: BorderSide(color: ColorConstants.mercury)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.person,
                size: 24,
                color: ColorConstants.chambray,
              ),
              const SizedBox(width: 12),
              Text(
                perfis?.nome ?? '',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          BlocBuilder<PerfisBloc, PerfisState>(
            builder: (context, state) {
              return Visibility(
                visible: state.hasExcluirPerfis,
                child: Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: IconButton(
                    onPressed: () {
                      _openDialogExcluir(
                        context,
                        state.perfilSelecionado,
                        context.read<PerfisBloc>(),
                      );
                    },
                    icon: const Icon(
                      Icons.delete_outline_rounded,
                      color: Color(
                        0xFFC0392B,
                      ),
                    ),
                    style: IconButton.styleFrom(
                      backgroundColor:
                          const Color(0xFFC0392B).withOpacity(0.15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _openDialogExcluir(context, PerfisModel? perfil, PerfisBloc bloc) {
    ConfirmDialog.show(
      context,
      titulo: 'Excluir perfil ${perfil?.nome}',
      mensagem: 'Deseja realmente excluir este perfil?',
      onConfirmar: () {
        bloc.add(PerfisExcluirPerfil(perfil!));
      },
      onCancelar: () {},
    );
  }
}
