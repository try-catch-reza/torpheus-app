import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../screens/perfis/bloc/perfis_bloc.dart';
import '../../screens/perfis/bloc/perfis_state.dart';

class AppBarMobile extends StatelessWidget {
  const AppBarMobile({
    super.key,
    required this.onAdd,
    required this.onDelete,
    required this.title,
    required this.hasPodeCriar,
    required this.hasPodeExcluir,
  });

  final VoidCallback onAdd;
  final VoidCallback onDelete;
  final String title;
  final bool hasPodeCriar;
  final bool hasPodeExcluir;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_rounded, size: 18),
        onPressed: () => Navigator.of(context).pop(),
      ),
      actions: [
        BlocBuilder<PerfisBloc, PerfisState>(
          builder: (context, state) {
            return Visibility(
              visible: state.hasCriarPerfis,
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: IconButton(
                  onPressed: onAdd,
                  icon: const Icon(Icons.add, color: Colors.white),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            );
          },
        ),

        // Botão Excluir
        BlocBuilder<PerfisBloc, PerfisState>(
          builder: (context, state) {
            return Visibility(
              visible: hasPodeExcluir,
              child: Padding(
                padding: const EdgeInsets.only(right: 12),
                child: IconButton(
                  onPressed: onDelete,
                  icon: const Icon(
                    Icons.delete_outline_rounded,
                    color: Color(
                      0xFFC0392B,
                    ),
                  ),
                  style: IconButton.styleFrom(
                    backgroundColor: const Color(0xFFC0392B).withOpacity(0.15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
