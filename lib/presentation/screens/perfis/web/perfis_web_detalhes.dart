import 'package:flutter/material.dart';
import 'package:torpheus/presentation/screens/perfis/bloc/perfis_state.dart';
import 'package:torpheus/presentation/screens/perfis/web/perfis_web_header.dart';
import 'package:torpheus/presentation/screens/perfis/web/perfis_web_permission_card.dart';

class PerfisWebDetalhes extends StatelessWidget {
  const PerfisWebDetalhes({super.key, required this.state});

  final PerfisState state;

  @override
  Widget build(BuildContext context) {
    if (state.perfilSelecionado == null) {
      return const Center(
        child: Text(
          'Selecione um perfil',
        ),
      );
    }

    return Column(
      children: [
        PerfisWebHeader(perfis: state.perfilSelecionado),
        Expanded(
          child: state.perfis.isEmpty
              ? const Center(
                  child: Text(
                    'Nenhuma permissão configurada para este perfil.',
                    style: TextStyle(fontSize: 13),
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: state.permissaoGrupo.length,
                  shrinkWrap: true,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final group = state.permissaoGrupo[index];

                    return PerfisWebPermissionCard(grupo: group);
                  },
                ),
        ),
      ],
    );
  }
}
