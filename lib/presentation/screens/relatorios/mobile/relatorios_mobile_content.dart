import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/components/loading_state.dart';
import 'package:torpheus/presentation/screens/relatorios/bloc/relatorios_bloc.dart';
import 'package:torpheus/presentation/screens/relatorios/mobile/relatorios_mobile_body.dart';

class RelatoriosMobileContent extends StatelessWidget {
  const RelatoriosMobileContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Relatórios'),
        ),
        body: BlocBuilder<RelatoriosBloc, RelatoriosState>(
          builder: (context, state) {
            if (state is RelatoriosLoading) {
              return const LoadingState();
            }

            if (state is RelatoriosLoaded) {
              return RelatoriosMobileBody(state: state);
            }

            return const SizedBox.shrink();
          },
        ));
  }
}
