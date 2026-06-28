import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/components/app_bar_padrao.dart';
import 'package:torpheus/presentation/components/dialog/dialog_mobile_padrao.dart';
import 'package:torpheus/presentation/components/loading_state.dart';
import 'package:torpheus/presentation/screens/analise_servico/bloc/analise_servico_bloc.dart';

import 'analise_servico_mobile_body.dart';

class AnaliseServicoMobileContent extends StatefulWidget {
  const AnaliseServicoMobileContent({super.key});

  @override
  State<AnaliseServicoMobileContent> createState() =>
      _AnaliseServicoMobileContentState();
}

class _AnaliseServicoMobileContentState
    extends State<AnaliseServicoMobileContent> {
  final TextEditingController horasController = TextEditingController();
  final TextEditingController minutosController = TextEditingController();
  final TextEditingController notaController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarPadrao(
        title: 'Análise do Serviço',
        hasLeading: true,
      ),
      body: BlocConsumer<AnaliseServicoBloc, AnaliseServicoState>(
        listener: _listener,
        buildWhen: _buildWhen,
        builder: (context, state) {
          if (state is AnaliseServicoLoading) {
            return const LoadingState();
          }

          if (state is AnaliseServicoLoaded) {
            return AnaliseServicoMobileBody(
              state: state,
              horasController: horasController,
              minutosController: minutosController,
              notaController: notaController,
              formKey: formKey,
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  void _listener(BuildContext context, AnaliseServicoState state) {
    if (state is AnaliseServicoHoraRegistrada) {
      horasController.clear();
      minutosController.clear();
      notaController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Hora registrada com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
    }

    if (state is AnaliseServicoFail) {
      DialogMobilePadrao.errorDialog(
        context: context,
        message: state.message,
        onPress: () {
          horasController.clear();
          minutosController.clear();
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
