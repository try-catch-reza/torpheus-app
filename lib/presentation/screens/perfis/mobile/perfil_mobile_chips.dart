import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/data/models/perfis_model.dart';

import '../bloc/perfis_bloc.dart';
import '../bloc/perfis_event.dart';
import '../bloc/perfis_state.dart';

class PerfilMobileChips extends StatelessWidget {
  const PerfilMobileChips({super.key, required this.state});

  final PerfisState state;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: List.generate(state.perfis.length, (i) {
            final perfil = state.perfis[i];
            final ativo = perfil.id == state.perfilSelecionado?.id;
            return Padding(
              padding: EdgeInsets.only(
                right: i < state.perfis.length - 1 ? 8 : 0,
              ),
              child: GestureDetector(
                onTap: () => onTap(perfil, context),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: ativo ? const Color(0xFF1E3A5F) : Colors.white,
                    borderRadius: BorderRadius.circular(99),
                    border: Border.all(
                      color: ativo
                          ? const Color(0xFF1E3A5F)
                          : const Color(0xFFDDDDD8),
                      width: 0.5,
                    ),
                  ),
                  child: Text(
                    state.perfis[i].nome ?? '',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: ativo ? Colors.white : const Color(0xFF6B6B67),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  void onTap(PerfisModel perfil, BuildContext context) {
    context.read<PerfisBloc>().add(PerfisSelect(perfil.id ?? ''));
  }
}
