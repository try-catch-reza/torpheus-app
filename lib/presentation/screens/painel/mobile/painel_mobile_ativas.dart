import 'package:flutter/material.dart';
import 'package:torpheus/presentation/screens/painel/bloc/painel_bloc.dart';
import 'package:torpheus/presentation/screens/painel/mobile/painel_mobile_card.dart';

class PainelMobileAtivas extends StatelessWidget {
  const PainelMobileAtivas({super.key, required this.state});

  final PainelState state;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: state.ordens.length,
        itemBuilder: (context, index) {
          final ordemServico = state.ordens[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0, top: 8),
            child: PainelMobileCard(ordemServico: ordemServico),
          );
        },
      ),
    );
  }
}
