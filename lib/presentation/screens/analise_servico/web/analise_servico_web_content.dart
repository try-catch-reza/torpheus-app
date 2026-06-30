import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/screens/analise_servico/bloc/analise_servico_bloc.dart';
import 'package:torpheus/presentation/screens/analise_servico/web/analise_servico_web_body.dart';

import '../../../components/dialog/dialog_web_padrao.dart';

class AnaliseServicoWebContent extends StatefulWidget {
  const AnaliseServicoWebContent({super.key});

  @override
  State<AnaliseServicoWebContent> createState() =>
      _AnaliseServicoWebContentState();
}

class _AnaliseServicoWebContentState extends State<AnaliseServicoWebContent> {
  final TextEditingController horaController = TextEditingController();
  final TextEditingController minutoController = TextEditingController();
  final TextEditingController notaController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AnaliseServicoBloc, AnaliseServicoState>(
        listener: _listener,
        buildWhen: _buildWhen,
        builder: (context, state) {
          if (state is AnaliseServicoLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is AnaliseServicoLoaded) {
            return AnaliseServicoWebBody(
              state: state,
              horaController: horaController,
              minutoController: minutoController,
              notaController: notaController,
              formKey: formKey,
            );
          }

          if (state is AnaliseServicoFail) {
            return Center(child: Text(state.message));
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  void _listener(BuildContext context, AnaliseServicoState state) {
    if (state is AnaliseServicoHoraRegistrada) {
      horaController.clear();
      minutoController.clear();
      notaController.clear();

      context.read<AnaliseServicoBloc>().add(
        AnaliseServicoLoad(
          ordemServicoId: state.ordemServico?.id ?? '',
          servicoId: state.servico?.id ?? '',
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Hora registrada com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
    }

    if (state is AnaliseServicoFail) {
      DialogWebPadrao.errorDialog(
        context: context,
        message: state.message,
        onPress: () {
          horaController.clear();
          minutoController.clear();
          notaController.clear();
          context.read<AnaliseServicoBloc>().add(
            AnaliseServicoLoad(
              ordemServicoId: state.ordemServico?.id ?? '',
              servicoId: state.servico?.id ?? '',
            ),
          );
        },
      );
    }
  }

  bool _buildWhen(AnaliseServicoState previous, AnaliseServicoState current) {
    return current is! AnaliseServicoHoraRegistrada;
  }
}
