import 'package:flutter/material.dart';
import 'package:torpheus/presentation/screens/login/bloc/login_bloc.dart';

import '../../../../core/constants/assets_contants.dart';
import '../../../../core/constants/color_constants.dart';
import 'login_mobile_card.dart';

class LoginMobileBody extends StatelessWidget {
  const LoginMobileBody({
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
    return Stack(
      children: [
        Positioned.fill(
          child: ColoredBox(color: ColorConstants.chambray),
        ),
        SafeArea(
          child: Column(
            children: [
              Image.asset(
                AssetsConstants.logoSemFundo,
                width: MediaQuery.of(context).size.width * 0.8,
              ),
              Expanded(
                child: LoginMobileCard(
                  state: state,
                  formKey: formKey,
                  controllerNome: controllerNome,
                  controllerSenha: controllerSenha,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
