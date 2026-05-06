import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/custom_colors.dart';
import '../bloc/login_bloc.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Campo e-mail é obrigatório';
                }

                if (!value.contains('@')) {
                  return 'E-mail digitado é inválido';
                }

                return null;
              },
              cursorColor: ColorConstants.chambray,
              decoration: InputDecoration(
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                ),
                disabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                ),
                prefixIcon: Icon(
                  Icons.email,
                  color: ColorConstants.chambray,
                ),
                hintText: 'E-mail',
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Campo senha é obrigatório';
                }

                return null;
              },
              cursorColor: ColorConstants.chambray,
              obscureText: !state.isMostrarSenha,
              decoration: InputDecoration(
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                ),
                disabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                ),
                prefixIcon: Icon(
                  Icons.lock,
                  color: ColorConstants.chambray,
                ),
                hintText: 'Senha',
                suffixIcon: IconButton(
                  onPressed: () {
                    context.read<LoginBloc>().add(const LoginMostrarSenha());
                  },
                  icon: state.isMostrarSenha
                      ? Icon(
                          Icons.visibility_sharp,
                          color: ColorConstants.chambray,
                        )
                      : Icon(
                          Icons.visibility_off,
                          color: ColorConstants.chambray,
                        ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                return ElevatedButton(
                  style: ButtonStyle(
                    fixedSize: WidgetStatePropertyAll(
                      Size(MediaQuery.of(context).size.width, 50),
                    ),
                  ),
                  onPressed: () {
                    if (formKey.currentState?.validate() ?? false) {
                      context.read<LoginBloc>().add(
                            LoginEnviar(
                              nome: controllerNome.text,
                              senha: controllerSenha.text,
                            ),
                          );
                    }
                  },
                  child: state is LoginLoading
                      ? const CircularProgressIndicator()
                      : const Text(
                          'ENTRAR',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                );
              },
            ),
            const SizedBox(height: 20),
            Center(
              child: GestureDetector(
                onTap: () {
                  // TODO: navegar para tela de recuperação de senha
                },
                child: RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF6B7A99),
                      decoration: TextDecoration.none,
                    ),
                    children: [
                      TextSpan(text: 'Esqueceu a senha? '),
                      TextSpan(
                        text: 'Recuperar acesso',
                        style: TextStyle(
                          color: Color(0xFF1B2A4A),
                          fontWeight: FontWeight.w700,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
