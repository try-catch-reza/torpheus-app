import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/components/loading_state.dart';
import 'package:torpheus/presentation/screens/cadastrar_cliente/bloc/cadastrar_cliente_bloc.dart';
import 'package:torpheus/presentation/screens/cadastrar_cliente/widgets/cadastrar_cliente_mobile_body.dart';

import '../../../components/app_bar_padrao.dart';

class CadastrarClienteContent extends StatelessWidget {
  const CadastrarClienteContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const AppBarPadrao(title: "Cadastrar Cliente"),
        body: BlocBuilder<CadastrarClienteBloc, CadastrarClienteState>(
          builder: (context, state) {
            if (state is CadastrarClienteLoading) {
              return const LoadingState();
            }

            if (state is CadastrarClienteLoaded) {
              return CadastrarClienteBody(
                onCadastrar: (dados) {},
              );
            }

            return const SizedBox.shrink();
          },
        ));
  }
}
