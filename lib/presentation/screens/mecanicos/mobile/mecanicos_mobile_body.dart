import 'package:flutter/material.dart';
import 'package:torpheus/presentation/screens/mecanicos/bloc/mecanicos_bloc.dart';

import '../widgets/mecanico_vazio.dart';
import 'mecanico_mobile_header.dart';
import 'mecanico_mobile_search.dart';
import 'mecanico_mobile_tabela.dart';

class MecanicosMobileBody extends StatelessWidget {
  const MecanicosMobileBody(
      {super.key, required this.state, required this.controller});

  final MecanicosState state;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const MecanicoMobileHeader(),
          const SizedBox(height: 24),
          MecanicoMobileSearch(controller: controller),
          const SizedBox(height: 16),
          if (state.mecanicos.isEmpty) const MecanicoVazio(),
          if (state.mecanicos.isNotEmpty)
            MecanicoMobileTabela(
              mecanicos: state.mecanicos,
              onMecanicoTap: (value) {},
            ),
        ],
      ),
    );
  }
}
