import 'package:flutter/material.dart';
import 'package:torpheus/presentation/screens/cadastrar_usuario/bloc/cadastrar_usuario_bloc.dart';

class CadastrarUsuarioMobileBody extends StatelessWidget {
  const CadastrarUsuarioMobileBody({
    super.key,
    required this.formKey,
    required this.nomeController,
    required this.emailController,
    required this.telefoneController,
    required this.documentoController,
    required this.cargoController,
    required this.state,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController nomeController;
  final TextEditingController emailController;
  final TextEditingController telefoneController;
  final TextEditingController documentoController;
  final TextEditingController cargoController;
  final CadastrarUsuarioLoaded state;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // TODO: implementar campos do formulário
          ],
        ),
      ),
    );
  }
}

