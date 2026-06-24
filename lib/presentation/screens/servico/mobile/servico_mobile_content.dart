import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/core/constants/enum/status_ordem.dart';
import 'package:torpheus/presentation/components/app_bar_padrao.dart';
import 'package:torpheus/presentation/components/dialog/dialog_confirm.dart';
import 'package:torpheus/presentation/components/dialog/dialog_mobile_padrao.dart';
import 'package:torpheus/presentation/components/loading_state.dart';
import 'package:torpheus/presentation/screens/servico/bloc/servico_bloc.dart';
import 'package:torpheus/presentation/screens/servico/mobile/servico_mobile_body.dart';

import '../../../components/app_button_bottom_navigation.dart';

class ServicoMobileContent extends StatefulWidget {
  const ServicoMobileContent({super.key});

  @override
  State<ServicoMobileContent> createState() => _ServicoMobileContentState();
}

class _ServicoMobileContentState extends State<ServicoMobileContent> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController descricaoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarPadrao(
        title: 'Detalhes da OS',
        hasLeading: true,
      ),
      body: BlocConsumer<ServicoBloc, ServicoState>(
        listener: _listener,
        builder: (context, state) {
          if (state is ServicoLoading) {
            return const LoadingState();
          }

          if (state is ServicoLoaded) {
            return ServicoMobileBody(
              state: state,
              descricaoController: descricaoController,
              formKey: formKey,
            );
          }

          return const SizedBox.shrink();
        },
      ),
      bottomNavigationBar: AppButtonBottomNavigation(
        onPressed: () {
          ConfirmDialog.show(
            context,
            titulo: 'Finalizar ordem de serviço',
            mensagem: 'Tem certeza que deseja finalizar a ordem de serviço? '
                'Essa ação não poderá ser desfeita.',
            onConfirmar: () {
              context.read<ServicoBloc>().add(
                    const ServicoTrocarStatusOS(status: StatusOrdem.completado),
                  );
            },
          );
        },
        icon: Icons.check_circle,
        text: 'Finalizar ordem de serviço',
      ),
    );
  }

  void _listener(BuildContext context, ServicoState state) {
    if (state is ServicoSalvo) {
      DialogMobilePadrao.successDialog(
        context: context,
        message: 'Serviço foi adicionado com sucesso!',
        onPress: () {
          context.read<ServicoBloc>().add(
                ServicoLoad(ordemServicoId: state.ordemServico?.id ?? ''),
              );
        },
      );
    }

    if (state is ServicoFail) {
      DialogMobilePadrao.errorDialog(
        context: context,
        message: state.message,
        onPress: () {
          context.read<ServicoBloc>().add(
                ServicoLoad(ordemServicoId: state.ordemServico?.id ?? ''),
              );
        },
      );
    }

    if (state is ServicoAtualizado) {
      DialogMobilePadrao.successDialog(
        context: context,
        message: 'Serviço foi atualizado com sucesso!',
        onPress: () {
          context.read<ServicoBloc>().add(
                ServicoLoad(ordemServicoId: state.ordemServico?.id ?? ''),
              );
        },
      );
    }

    if (state is ServicoConcluido) {
      DialogMobilePadrao.successDialog(
        context: context,
        message: 'Serviço foi concluído com sucesso!',
        onPress: () {
          context.read<ServicoBloc>().add(
                ServicoLoad(ordemServicoId: state.ordemServico?.id ?? ''),
              );
        },
      );
    }
  }
}
