import 'package:flutter/material.dart';
import 'package:torpheus/config/routes.dart';
import 'package:torpheus/presentation/components/mobile/app_bar_mobile_search.dart';
import 'package:torpheus/presentation/screens/cadastrar_veiculo/cadastrar_veiculo_screen.dart';
import 'package:torpheus/presentation/screens/veiculos/bloc/veiculos_bloc.dart';
import 'package:torpheus/presentation/screens/veiculos/mobile/veiculos_mobile_lista.dart';

import '../../../components/lista_vazia_custom.dart';
import '../../veiculo_detalhe/veiculo_detalhe_screen.dart';

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
        AppBarMobileSearch(
          onPressed: () {
            Navigator.of(context).pushNamed(
              AppRoutes.cadastrarVeiculo.route,
              arguments: CadastrarVeiculoArguments(),
            );
          },
          title: 'Veículos',
          subtitle: 'Cadastro e histórico de veículos',
          controller: controller,
          hintText: 'Pesquisar por placa',
          hasPodeCriar: state.hasCriarVeiculo,
        ),
        if (state.veiculos.isEmpty)
          const ListaVaziaCustom(
            message: 'Nenhum veículo encontrado',
            subMessage: 'Cadastre um novo veículo para começar a gerenciar',
          ),
        if (state.veiculos.isNotEmpty)
          VeiculosMobileLista(
            veiculos: state.veiculos,
            onVeiculoTap: (value) {
              Navigator.of(context).pushNamed(
                AppRoutes.veiculoDetalhe.route,
                arguments: VeiculoDetalheArguments(veiculo: value),
              );
            },
          )
      ],
    );
  }
}
