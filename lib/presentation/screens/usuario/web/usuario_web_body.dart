import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/screens/usuario/bloc/usuario_bloc.dart';
import 'package:torpheus/presentation/screens/usuario/web/usuario_web_table.dart';

import '../../../../core/constants/color_constants.dart';
import '../../../../data/models/perfis_model.dart';
import '../../../components/app_cancel_button.dart';
import '../../../components/app_dropdown_field.dart';
import '../../../components/app_primary_button.dart';
import '../../../components/app_text_field.dart';
import '../../../components/lista_vazia_custom.dart';
import '../../../components/search_custom.dart';
import '../../../components/web/header_web_custom.dart';

class UsuarioWebBody extends StatelessWidget {
  const UsuarioWebBody({
    super.key,
    required this.state,
    required this.searchController,
    required this.formKey,
    required this.nomeController,
    required this.emailController,
    required this.senhaController,
  });

  final UsuarioState state;
  final TextEditingController searchController;
  final TextEditingController nomeController;
  final TextEditingController emailController;
  final TextEditingController senhaController;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderWebCustom(
            hasPodeCriar: state.hasCriarUsuario,
            title: 'Usuarios',
            subtitle: 'Gerencie os usuários cadastrados no sistema',
            buttonText: 'Cadastrar usuário',
            onPressed: () => _onShowDialogCadastrarUsuario(context),
          ),
          SearchCustom(
            controller: searchController,
            hintText: 'Pesquisar por nome',
            onChanged: (value) {
              context.read<UsuarioBloc>().add(UsuarioSearch(value));
            },
          ),
          if (state.usuariosFiltered.isEmpty)
            const ListaVaziaCustom(
              message: 'Nenhum usuário encontrado',
              subMessage: 'Cadastre um novo usuário para começar a gerenciar',
            ),
          if (state.usuariosFiltered.isNotEmpty)
            UsuarioWebTable(usuarios: state.usuariosFiltered),
        ],
      ),
    );
  }

  _onShowDialogCadastrarUsuario(BuildContext context) {
    final bloc = context.read<UsuarioBloc>();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return BlocProvider.value(
          value: bloc,
          child: BlocBuilder<UsuarioBloc, UsuarioState>(
            builder: (context, state) {
              return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Form(
                  key: formKey,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    padding: const EdgeInsets.all(24),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Cadastrar usuário',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  color: ColorConstants.chambray,
                                ),
                              ),
                              IconButton(
                                padding: const EdgeInsets.only(bottom: 5),
                                onPressed: () => Navigator.pop(context),
                                icon: const Icon(Icons.close, size: 30),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Divider(),
                          const SizedBox(height: 16),
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
                            enabled: state is! UsuarioSalvando,
                            controller: nomeController,
                            label: 'Nome',
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
                              context.read<UsuarioBloc>().add(
                                    UsuarioSetPerfil(value!),
                                  );
                            },
                            validator: (p0) {
                              if (p0 == null) {
                                return 'Selecione um perfil para o usuário';
                              }

                              return null;
                            },
                          ),
                          const SizedBox(height: 32),
                          const Divider(),
                          const SizedBox(height: 16),
                          LayoutBuilder(
                            builder: (context, constraints) {
                              if (constraints.maxWidth < 350) {
                                return state is UsuarioSalvando
                                    ? const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : Center(
                                        child: Column(
                                          children: [
                                            AppCancelButton(
                                              text: 'Cancelar',
                                              icon: Icons.close,
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                            ),
                                            const SizedBox(height: 12),
                                            AppPrimaryButton(
                                              text: 'Cadastrar usuário',
                                              icon: Icons.check,
                                              onPressed: () {
                                                _onCadastrarUsuario(
                                                  context,
                                                  bloc,
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                              }

                              return state is UsuarioSalvando
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        AppCancelButton(
                                          text: 'Cancelar',
                                          icon: Icons.close,
                                          onPressed: () =>
                                              Navigator.pop(context),
                                        ),
                                        const SizedBox(width: 12),
                                        AppPrimaryButton(
                                          text: 'Cadastrar usuário',
                                          icon: Icons.check,
                                          onPressed: () {
                                            _onCadastrarUsuario(context, bloc);
                                          },
                                        ),
                                      ],
                                    );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _onCadastrarUsuario(BuildContext context, UsuarioBloc bloc) {
    if (formKey.currentState?.validate() ?? false) {
      context.read<UsuarioBloc>().add(
            UsuarioSubmit(
              senha: senhaController.text,
              nome: nomeController.text,
              email: emailController.text,
            ),
          );
    }
  }
}
