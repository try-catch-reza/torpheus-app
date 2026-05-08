import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/screens/recuperar_senha/mobile/recuperar_senha_mobile_body.dart';

import '../bloc/recuperar_senha_bloc.dart';

class RecuperarSenhaMobileContent extends StatelessWidget {
  const RecuperarSenhaMobileContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<RecuperarSenhaBloc, RecuperarSenhaState>(
        builder: (context, state) {
          if (state is RecuperarSenhaLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is RecuperarSenhaLoaded) {
            return const RecuperarSenhaMobileBody();
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
