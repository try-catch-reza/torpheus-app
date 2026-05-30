import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/screens/cadastrar_funcionario/cadastrar_funcionario_screen.dart';

import '../../../components/loading_state.dart';
import '../../cadastrar_funcionario/bloc/cadastrar_funcionario_bloc.dart';
import '../bloc/funcionario_bloc.dart';
import 'funcionario_web_body.dart';

class FuncionarioWebContent extends StatefulWidget {
  const FuncionarioWebContent({super.key});

  @override
  State<FuncionarioWebContent> createState() => _FuncionarioWebContentState();
}

class _FuncionarioWebContentState extends State<FuncionarioWebContent> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FuncionarioBloc, FuncionarioState>(
        builder: (context, state) {
          if (state is FuncionarioLoading) {
            return const LoadingState();
          }

          if (state is FuncionarioLoaded) {
            return FuncionarioWebBody(
              state: state,
              controller: _searchController,
            );
          }

          if (state is FuncionarioCadastrando) {
            return CadastrarFuncionarioScreen(
              cadastrarFuncionarioBloc: context.read<CadastrarFuncionarioBloc>(),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
