import 'package:flutter/material.dart';
import 'package:torpheus/core/constants/custom_colors.dart';
import 'package:torpheus/presentation/screens/login/web/login_web_painel_esquerdo.dart';
import 'package:torpheus/presentation/screens/login/widgets/login_form.dart';

import '../bloc/login_bloc.dart';

class LoginWebBody extends StatelessWidget {
  const LoginWebBody({
    super.key,
    required this.state,
    required this.controllerNome,
    required this.controllerSenha,
    required this.formKey,
  });

  final LoginState state;
  final TextEditingController controllerNome;
  final TextEditingController controllerSenha;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const LoginWebPainelEsquerdo(),
        Container(
          color: ColorConstants.corFundo,
          width: MediaQuery.of(context).size.width * 0.3,
          child: LoginForm(
            state: state,
            formKey: formKey,
            controllerSenha: controllerSenha,
            controllerNome: controllerNome,
          ),
        ),
      ],
    );
  }
}
