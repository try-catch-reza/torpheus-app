import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/screens/analise_servico/bloc/analise_servico_bloc.dart';
import 'package:torpheus/presentation/screens/analise_servico/web/analise_servico_web_body.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AnaliseServicoBloc, AnaliseServicoState>(
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
}
