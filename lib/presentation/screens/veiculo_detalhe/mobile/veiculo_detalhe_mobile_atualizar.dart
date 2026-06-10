import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/screens/veiculo_detalhe/bloc/veiculo_detalhe_bloc.dart';

import '../../../../config/routes.dart';
import '../../../components/app_button_bottom_navigation.dart';
import '../../cadastrar_veiculo/cadastrar_veiculo_screen.dart';

class VeiculoDetalheMobileAtualizar extends StatelessWidget {
  const VeiculoDetalheMobileAtualizar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VeiculoDetalheBloc, VeiculoDetalheState>(
      builder: (context, state) {
        return Visibility(
          visible: state.hasEditarVeiculo,
          child: AppButtonBottomNavigation(
            icon: Icons.edit,
            text: 'Editar dados do veículo',
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(
                AppRoutes.cadastrarVeiculo.route,
                arguments: CadastrarVeiculoArguments(
                  isEdit: true,
                  veiculoId: state.veiculo?.id ?? '',
                ),
              ).then((_) {
                  context.read<VeiculoDetalheBloc>().add(
                    VeiculoDetalheLoad(state.veiculo),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
