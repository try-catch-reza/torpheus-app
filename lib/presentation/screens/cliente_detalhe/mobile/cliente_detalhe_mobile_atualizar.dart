import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/screens/cliente_detalhe/bloc/cliente_detalhe_bloc.dart';

import '../../../../config/routes.dart';
import '../../../components/app_button_bottom_navigation.dart';
import '../../cadastrar_cliente/cadastrar_cliente_screen.dart';

class ClienteDetalheMobileAtualizar extends StatelessWidget {
  const ClienteDetalheMobileAtualizar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClienteDetalheBloc, ClienteDetalheState>(
      builder: (context, state) {
        return AppButtonBottomNavigation(
          icon: Icons.edit,
          text: 'Editar dados do cliente',
          onPressed: () {
            Navigator.of(context).pushNamed(
              AppRoutes.cadastrarCliente.route,
              arguments: CadastrarClienteArguments(
                clienteId: state.cliente?.id ?? '',
                isEdit: true,
              ),
            );
          },
        );
      },
    );
  }
}
