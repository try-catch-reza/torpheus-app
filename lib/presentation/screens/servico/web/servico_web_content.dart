import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/screens/servico/bloc/servico_bloc.dart';
import 'package:torpheus/presentation/screens/servico/web/servico_web_body.dart';

import '../../../components/dialog/dialog_web_padrao.dart';

class ServicoWebContent extends StatefulWidget {
  const ServicoWebContent({super.key});

  @override
  State<ServicoWebContent> createState() => _ServicoWebContentState();
}

class _ServicoWebContentState extends State<ServicoWebContent> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController descricaoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ServicoBloc, ServicoState>(
        listener: _listener,
        builder: (context, state) {
          if (state is ServicoLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ServicoLoaded) {
            return ServicoWebBody(
              state: state,
              descricaoController: descricaoController,
              formKey: formKey,
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  void _listener(BuildContext context, ServicoState state) {
    if (state is ServicoSalvo) {
      DialogWebPadrao.successDialog(
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
      DialogWebPadrao.errorDialog(
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
      DialogWebPadrao.successDialog(
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
      DialogWebPadrao.successDialog(
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
