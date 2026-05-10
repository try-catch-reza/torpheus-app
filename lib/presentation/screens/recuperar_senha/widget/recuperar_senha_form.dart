import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/recuperar_senha_bloc.dart';

class RecuperarSenhaForm extends StatefulWidget {
  const RecuperarSenhaForm({super.key});

  @override
  State<RecuperarSenhaForm> createState() => _RecuperarSenhaFormState();
}

class _RecuperarSenhaFormState extends State<RecuperarSenhaForm> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecuperarSenhaBloc, RecuperarSenhaState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: const Color(0xFFE8ECF4),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(
                Icons.lock_reset_rounded,
                color: Color(0xFF1B2A4A),
                size: 26,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Recuperar senha',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1B2A4A),
                decoration: TextDecoration.none,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Informe o e-mail da sua conta. Enviaremos um link para você criar uma nova senha.',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF6B7A99),
                height: 1.5,
                decoration: TextDecoration.none,
              ),
            ),
            const SizedBox(height: 28),
            Form(
              key: _formKey,
              child: TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo e-mail é obrigatório';
                  }

                  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');

                  if (!emailRegex.hasMatch(value)) {
                    return 'Por favor, insira um e-mail válido';
                  }
                  return null;
                },
                onFieldSubmitted: (value) {
                  if (_formKey.currentState?.validate() ?? false) {
                    context.read<RecuperarSenhaBloc>().add(
                          RecuperarSenhaSolicitar(
                            email: _emailController.text,
                          ),
                        );
                  }
                },
                decoration: const InputDecoration(
                  hintText: 'seu@email.com',
                  prefixIcon: Icon(
                    Icons.mail_outline_rounded,
                    color: Color(0xFF8FA3C0),
                    size: 18,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    context.read<RecuperarSenhaBloc>().add(
                          RecuperarSenhaSolicitar(
                            email: _emailController.text,
                          ),
                        );
                  }
                },
                child: const Text(
                  'ENVIAR LINK',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.5,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF6B7A99),
                      decoration: TextDecoration.none,
                    ),
                    children: [
                      TextSpan(text: 'Lembrou a senha? '),
                      TextSpan(
                        text: 'Faça login',
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
        );
      },
    );
  }
}
