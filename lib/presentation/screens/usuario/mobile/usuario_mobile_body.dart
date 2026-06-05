import 'package:flutter/material.dart';
import 'package:torpheus/config/routes.dart';
import 'package:torpheus/presentation/components/mobile/app_bar_mobile_search.dart';
import 'package:torpheus/presentation/screens/usuario/bloc/usuario_bloc.dart';

import '../../../components/lista_vazia_custom.dart';
import 'usuario_mobile_lista.dart';

class UsuarioMobileBody extends StatelessWidget {
  const UsuarioMobileBody({
    super.key,
    required this.state,
    required this.controller,
  });

  final UsuarioState state;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppBarMobileSearch(
          onPressed: () {
            Navigator.of(context).pushNamed(AppRoutes.cadastrarUsuario.route);
          },
          title: 'Usuários',
          subtitle: 'Gerencie os usuários do sistema',
          controller: controller,
          hasPodeCriar: state.hasCriarUsuario,
        ),
        if (state.usuarios.isEmpty)
          const ListaVaziaCustom(
            message: 'Nenhum usuário encontrado',
            subMessage: 'Cadastre um novo usuário',
          ),
        if (state.usuarios.isNotEmpty)
          UsuarioMobileLista(
            usuarios: state.usuarios,
            onUsuarioTap: (value) {},
          ),
      ],
    );
  }
}
