import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/core/constants/color_constants.dart';
import 'package:torpheus/presentation/components/app_cancel_button.dart';
import 'package:torpheus/presentation/components/app_primary_button.dart';
import 'package:torpheus/presentation/components/app_text_field.dart';
import 'package:torpheus/presentation/screens/perfis/bloc/perfis_bloc.dart';
import 'package:torpheus/presentation/screens/perfis/bloc/perfis_event.dart';
import 'package:torpheus/presentation/screens/perfis/bloc/perfis_state.dart';
import 'package:torpheus/presentation/screens/perfis/web/perfis_web_detalhes.dart';
import 'package:torpheus/presentation/screens/perfis/web/perfis_web_sidebar.dart';

class PerfisWebBody extends StatelessWidget {
  const PerfisWebBody({
    super.key,
    required this.state,
    required this.nameController,
    required this.formKey,
  });

  final PerfisState state;
  final TextEditingController nameController;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        PerfisWebSidebar(
          hasCriarPerfis: state.hasCriarPerfis,
          perfis: state.perfis,
          onNewProfile: () => _openNewPerfisDialog(context),
        ),
        Expanded(
          child: PerfisWebDetalhes(state: state),
        ),
      ],
    );
  }

  void _openNewPerfisDialog(BuildContext context) {
    final bloc = context.read<PerfisBloc>();

    nameController.clear();

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            width: 400,
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
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      AppCancelButton(
                        text: 'Cancelar',
                        icon: Icons.clear,
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      const SizedBox(width: 8),
                      AppPrimaryButton(
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

  void _submit(BuildContext context, PerfisBloc bloc, String nome) {
    if (formKey.currentState!.validate()) {
      bloc.add(PerfisCriar(nome));

      Navigator.of(context).pop();
    }
  }
}
