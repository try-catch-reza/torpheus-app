import 'package:flutter/material.dart';
import 'package:torpheus/core/constants/color_constants.dart';
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
          width: MediaQuery.of(context).size.width * 0.30,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 24, left: 24, top: 28),
                child: Text(
                  'Bem-vindo de volta 👋',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1B2A4A),
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'Acesse sua conta para continuar',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF6B7A99),
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
              const SizedBox(height: 28),
              LoginForm(
                state: state,
                formKey: formKey,
                controllerSenha: controllerSenha,
                controllerNome: controllerNome,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
