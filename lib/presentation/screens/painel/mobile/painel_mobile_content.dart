import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/screens/painel/bloc/painel_bloc.dart';
import 'package:torpheus/presentation/screens/painel/mobile/painel_mobile_body.dart';
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
      ),
      body: BlocBuilder<PainelBloc, PainelState>(
        builder: (context, state) {
          if (state is PainelLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is PainelLoaded) {
            return PainelMobileBody(state: state);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
