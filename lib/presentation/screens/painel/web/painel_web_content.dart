import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/components/loading_state.dart';
import 'package:torpheus/presentation/screens/painel/bloc/painel_bloc.dart';
import 'package:torpheus/presentation/screens/painel/web/painel_web_body.dart';

class PainelWebContent extends StatelessWidget {
  const PainelWebContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PainelBloc, PainelState>(
        builder: (context, state) {
          if (state is PainelLoading) {
            return const LoadingState();
          }

          if (state is PainelLoaded) {
            return PainelWebBody(state: state);
          }

          if (state is PainelFail) {
            return Center(
              child: Text(state.message),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
