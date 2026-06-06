import 'package:flutter/material.dart';
import 'package:torpheus/presentation/screens/perfis/bloc/perfis_state.dart';
import 'package:torpheus/presentation/screens/perfis/mobile/perfis_mobile_card.dart';

class PerfilMobileLista extends StatelessWidget {
  const PerfilMobileLista({super.key, required this.state});

  final PerfisState state;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
        itemCount: state.permissaoGrupo.length,
        itemBuilder: (context, index) {
          final grupo = state.permissaoGrupo[index];

          return PerfisMobileCard(grupo: grupo);
        },
      ),
    );
  }
}
