import 'package:flutter/material.dart';
import 'package:torpheus/presentation/components/web/header_web_custom.dart';
import 'package:torpheus/presentation/screens/veiculos/bloc/veiculos_bloc.dart';

import '../../../components/lista_vazia_custom.dart';
import '../../../components/search_custom.dart';
import '../widgets/veiculos_lista.dart';

class VeiculosWebBody extends StatelessWidget {
  const VeiculosWebBody({
    super.key,
    required this.state,
    required this.searchController,
  });

  final VeiculosState state;
  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderWebCustom(
            title: 'Veículos',
            subtitle: 'Gerencie os veículos cadastrados no sistema',
            buttonText: 'Cadastrar Veículo',
            onPressed: () {},
          ),
          SearchCustom(
            controller: searchController,
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
            ),
        ],
      ),
    );
  }
}
