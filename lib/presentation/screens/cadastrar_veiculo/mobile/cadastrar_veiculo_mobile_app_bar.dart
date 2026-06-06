import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/components/app_bar_padrao.dart';
import 'package:torpheus/presentation/screens/cadastrar_veiculo/bloc/cadastrar_veiculo_bloc.dart';

class CadastrarVeiculoMobileAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const CadastrarVeiculoMobileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CadastrarVeiculoBloc, CadastrarVeiculoState>(
      builder: (context, state) {
        if (state.isEdit) {
          return const AppBarPadrao(
            title: 'Editar veículo',
            hasLeading: true,
          );
        } else {
          return const AppBarPadrao(
            title: 'Cadastrar veículo',
            hasLeading: true,
          );
        }
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
