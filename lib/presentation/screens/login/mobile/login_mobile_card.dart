import 'package:flutter/material.dart';

import '../bloc/login_bloc.dart';
import '../widgets/login_form.dart';

class LoginMobileCard extends StatelessWidget {
  const LoginMobileCard({
    super.key,
    required this.state,
    required this.formKey,
    required this.controllerNome,
    required this.controllerSenha,
  });

  final LoginState state;
  final GlobalKey<FormState> formKey;
  final TextEditingController controllerNome;
  final TextEditingController controllerSenha;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFFF0F2F5),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
    );
  }
}
