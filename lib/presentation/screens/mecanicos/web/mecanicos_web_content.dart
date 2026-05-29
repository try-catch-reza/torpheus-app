import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/screens/cadastrar_mecanico/bloc/cadastrar_mecanico_bloc.dart';
import 'package:torpheus/presentation/screens/cadastrar_mecanico/cadastrar_mecanico_screen.dart';

import '../../../components/loading_state.dart';
import '../bloc/mecanicos_bloc.dart';
import 'mecanico_web_body.dart';

class MecanicosWebContent extends StatefulWidget {
  const MecanicosWebContent({super.key});

  @override
  State<MecanicosWebContent> createState() => _MecanicosWebContentState();
}

class _MecanicosWebContentState extends State<MecanicosWebContent> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FuncionarioBloc, MecanicosState>(
        builder: (context, state) {
          if (state is MecanicosLoading) {
            return const LoadingState();
          }

          if (state is MecanicosLoaded) {
            return MecanicosWebBody(
              state: state,
              controller: _searchController,
            );
          }

          if (state is MecanicoCadastrando) {
            return CadastrarMecanicoScreen(
              cadastrarMecanicoBloc: context.read<CadastrarMecanicoBloc>(),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
