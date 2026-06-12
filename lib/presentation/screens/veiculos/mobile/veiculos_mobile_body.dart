import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/config/routes.dart';
import 'package:torpheus/data/models/veiculo_model.dart';
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
            ).then((_) {
              context.read<VeiculosBloc>().add(const VeiculosLoad());
            });
          },
          onChanged: (value) {
            context.read<VeiculosBloc>().add(VeiculoSearch(value));
          },
          title: 'Veículos',
          subtitle: 'Cadastro e histórico de veículos',
          controller: controller,
          hintText: 'Pesquisar por placa',
          hasPodeCriar: state.hasCriarVeiculo,
        ),
        if (state.veiculosFiltered.isEmpty)
          const ListaVaziaCustom(
            message: 'Nenhum veículo encontrado',
            subMessage: 'Cadastre um novo veículo para começar a gerenciar',
          ),
        if (state.veiculosFiltered.isNotEmpty)
          VeiculosMobileLista(
            veiculos: state.veiculosFiltered,
            onVeiculoTap: (value) => _onTap(context, value),
          )
      ],
    );
  }

  void _onTap(BuildContext context, VeiculoModel veiculo) {
    Navigator.of(context).pushNamed(
      AppRoutes.veiculoDetalhe.route,
      arguments: VeiculoDetalheArguments(veiculo: veiculo),
    ).then((_) {
      context.read<VeiculosBloc>().add(const VeiculosLoad());
    });
  }
}
