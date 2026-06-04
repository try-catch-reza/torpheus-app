import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/data/models/perfis_model.dart';
import 'package:torpheus/presentation/components/app_dropdown_field.dart';
import 'package:torpheus/presentation/components/app_text_field.dart';
import 'package:torpheus/presentation/screens/cadastrar_usuario/bloc/cadastrar_usuario_bloc.dart';

class CadastrarUsuarioMobileBody extends StatelessWidget {
  const CadastrarUsuarioMobileBody({
    super.key,
    required this.formKey,
    required this.nomeController,
    required this.emailController,
    required this.senhaController,
    required this.state,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController nomeController;
  final TextEditingController emailController;
  final TextEditingController senhaController;
  final CadastrarUsuarioLoaded state;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'IDENTIFICAÇÃO',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 16),
            AppTextField(
              label: 'Nome',
              controller: nomeController,
              validator: (p0) {
                if (p0 == null || p0.isEmpty) {
                  return 'Campo nome é obrigatório';
                }

                return null;
              },
            ),
            const SizedBox(height: 16),
            AppTextField(
              label: 'Email',
              controller: emailController,
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
            ),
            const SizedBox(height: 16),
            AppTextField(
              label: 'Senha',
              controller: senhaController,
              validator: (p0) {
                if (p0 == null || p0.isEmpty) {
                  return 'Campo senha é obrigatório';
                }

                if (p0.length < 6) {
                  return 'Digite uma senha maior';
                }

                return null;
              },
            ),
            const SizedBox(height: 16),
            AppDropdownField<PerfisModel>(
              label: 'Selecione o perfil do usuário',
              items: state.perfis.map(
                (e) {
                  return DropdownMenuItem(
                    value: e,
                    child: Text(e.nome ?? ''),
                  );
                },
              ).toList(),
              onChanged: (value) {
                context.read<CadastrarUsuarioBloc>().add(
                      CadastrarUsuarioSetPerfil(value!),
                    );
              },
              validator: (p0) {
                if (p0 == null) {
                  return 'Selecione um perfil para o usuário';
                }

                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
