import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/screens/recuperar_senha/bloc/recuperar_senha_bloc.dart';
import 'package:torpheus/presentation/screens/recuperar_senha/web/recuperar_senha_web_body.dart';

class RecuperarSenhaWebContent extends StatelessWidget {
  const RecuperarSenhaWebContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<RecuperarSenhaBloc, RecuperarSenhaState>(
        builder: (context, state) {
          if (state is RecuperarSenhaLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is RecuperarSenhaLoaded) {
            return const RecuperarSenhaWebBody();
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
