import 'package:flutter/material.dart';
import 'package:torpheus/config/routes.dart';
import 'package:torpheus/presentation/screens/cadastrar_veiculo/cadastrar_veiculo_screen.dart';
import 'package:torpheus/presentation/screens/veiculos/bloc/veiculos_bloc.dart';

import '../../../components/mobile/header_mobile_custom.dart';
import '../../../components/lista_vazia_custom.dart';
import '../../../components/search_custom.dart';
import '../widgets/veiculos_lista.dart';

class VeiculosMobileBody extends StatelessWidget {
  const VeiculosMobileBody({
    super.key,
    required this.state,
    required this.controller,
  });

  final VeiculosState state;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeaderMobileCustom(
          title: 'Veículos',
          subtitle: 'Cadastro e histórico de veículos',
          onPressed: () {
            Navigator.of(context).pushNamed(
              AppRoutes.cadastrarVeiculo.route,
              arguments: CadastrarVeiculoArguments(),
            );
          },
        ),
        SearchCustom(
          width: double.infinity,
          controller: controller,
          hintText: 'Pesquisar por placa',
        ),
        if (state.veiculos.isEmpty)
          const ListaVaziaCustom(
            message: 'Nenhum veículo encontrado',
            subMessage: 'Cadastre um novo veículo para começar a gerenciar',
          ),
        if (state.veiculos.isNotEmpty)
          VeiculosLista(
            veiculos: state.veiculos,
            onVeiculoTap: (value) {},
          )
      ],
    );
  }
}
