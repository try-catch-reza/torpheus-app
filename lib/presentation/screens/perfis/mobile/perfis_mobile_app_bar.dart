import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/data/models/perfis_model.dart';
import 'package:torpheus/presentation/components/dialog/dialog_confirm.dart';
import 'package:torpheus/presentation/components/mobile/app_bar_mobile.dart';
import 'package:torpheus/presentation/screens/perfis/bloc/perfis_bloc.dart';
import 'package:torpheus/presentation/screens/perfis/bloc/perfis_state.dart';

import '../../../../core/constants/color_constants.dart';
import '../../../components/app_cancel_button.dart';
import '../../../components/app_primary_button.dart';
import '../../../components/app_text_field.dart';
import '../bloc/perfis_event.dart';

class PerfisMobileAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const PerfisMobileAppBar({
    super.key,
    required this.formKey,
    required this.nameController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PerfisBloc, PerfisState>(
      builder: (context, state) {
        return AppBarMobile(
          hasPodeCriar: state.hasCriarPerfis,
          hasPodeExcluir:
              state.hasExcluirPerfis && state.perfilSelecionado != null,
          title: 'Perfis de acesso',
          onAdd: () => _openNewPerfisDialog(context),
          onDelete: () => _openDialogExcluir(
            context,
            state.perfilSelecionado,
            context.read<PerfisBloc>(),
          ),
        );
      },
    );
  }

  void _openNewPerfisDialog(BuildContext context) {
    final bloc = context.read<PerfisBloc>();

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: const EdgeInsets.all(24),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Novo Perfil',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: ColorConstants.chromaphobicBlack,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Preencha os dados do novo perfil de acesso.',
                    style: TextStyle(
                      fontSize: 13,
                      color: ColorConstants.chambray,
                    ),
                  ),
                  const SizedBox(height: 20),
                  AppTextField(
                    label: 'Nome',
                    controller: nameController,
                    validator: (p0) {
                      if (p0 == null || p0.isEmpty) {
                        return 'Campo nome é obrigatório';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      AppCancelButton(
                        text: 'Cancelar',
                        icon: Icons.clear,
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      const SizedBox(width: 8),
                      AppPrimaryButton(
                        fontSize: 13,
                        text: 'Criar perfil',
                        icon: Icons.check,
                        onPressed: () => _submit(
                          context,
                          bloc,
                          nameController.text,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
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

  void _submit(BuildContext context, PerfisBloc bloc, String nome) {
    if (formKey.currentState!.validate()) {
      bloc.add(PerfisCriar(nome));

      Navigator.of(context).pop();
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
