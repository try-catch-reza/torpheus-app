import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/core/constants/custom_colors.dart';
import 'package:torpheus/presentation/screens/painel/mobile/painel_mobile_drawer.dart';

import '../../../../config/routes.dart';
import '../../../components/dialog/dialog_confirm.dart';
import '../../login/bloc/login_bloc.dart';

class PainelMobileContent extends StatelessWidget {
  const PainelMobileContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: TorpheusDrawer(
        nomeUsuario: 'Huandres Schmidt',
        cargoUsuario: 'Administrador',
        emailUsuario: 'huandreschmidt@gmail.com',
        onSairTap: () {
          ConfirmDialog.show(
            context,
            titulo: 'Sair do Aplicativo',
            mensagem: 'Tem certeza que deseja sair do aplicativo?',
            onConfirmar: () {
              context.read<LoginBloc>().add(const LoginLogout());
              Navigator.of(context).pushReplacementNamed(AppRoutes.root.route);
            },
          );
        },
      ),
      appBar: AppBar(
        title: const Text('Painel Geral'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              elevation: 0.0,
              onPressed: () {},
              backgroundColor: ColorConstants.chambray,
              child: const Icon(Icons.add, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
