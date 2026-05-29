import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/screens/mecanicos/bloc/mecanicos_bloc.dart';

import 'mecanico_web_header.dart';
import 'mecanico_web_search.dart';
import 'mecanico_web_tabela.dart';
import '../widgets/mecanico_vazio.dart';

class MecanicosWebBody extends StatelessWidget {
  const MecanicosWebBody({
    super.key,
    required this.state,
    required this.controller,
  });

  final MecanicosState state;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const MecanicoWebHeader(),
          const SizedBox(height: 24),
          Row(
            children: [
              MecanicoWebSearch(controller: controller),
              const SizedBox(width: 16),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 16),
          if (state.funcionarios.isEmpty)
            const MecanicoVazio(),
          if (state.funcionarios.isNotEmpty)
            MecanicoWebTabela(
              mecanicos: state.funcionarios,
              onMecanicoTap: (value) {
                context.read<FuncionarioBloc>().add(const MecanicosCadastrar());
              },
            ),
        ],
      ),
    );
  }
}
