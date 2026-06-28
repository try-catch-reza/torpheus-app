import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/components/loading_state.dart';
import 'package:torpheus/presentation/screens/relatorios/bloc/relatorios_bloc.dart';
import 'package:torpheus/presentation/screens/relatorios/web/relatorios_web_body.dart';

class RelatoriosWebContent extends StatelessWidget {
  const RelatoriosWebContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<RelatoriosBloc, RelatoriosState>(
        builder: (context, state) {
          if (state is RelatoriosLoading) {
            return const LoadingState();
          }

          if (state is RelatoriosLoaded) {
            return RelatoriosWebBody(state: state);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
