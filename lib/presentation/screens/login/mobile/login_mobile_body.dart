import 'package:flutter/material.dart';
import 'package:torpheus/presentation/screens/login/bloc/login_bloc.dart';

import '../../../../core/constants/custom_colors.dart';
import 'login_mobile_card.dart';
import 'login_mobile_grid.dart';
import 'login_mobile_header.dart';

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
        Positioned.fill(
          child: CustomPaint(painter: LoginMobileGrid()),
        ),
        SafeArea(
          child: Column(
            children: [
              const LoginMobileHeader(),
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
