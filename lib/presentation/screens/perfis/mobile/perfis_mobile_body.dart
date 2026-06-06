import 'package:flutter/material.dart';
import 'package:torpheus/presentation/screens/perfis/bloc/perfis_state.dart';
import 'package:torpheus/presentation/screens/perfis/mobile/perfil_mobile_chips.dart';
import 'package:torpheus/presentation/screens/perfis/mobile/perfil_mobile_lista.dart';

class PerfisMobileBody extends StatelessWidget {
  const PerfisMobileBody({super.key, required this.state});

  final PerfisState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PerfilMobileChips(state: state),
        const Divider(height: 1, thickness: 0.5),
        PerfilMobileLista(state: state),
      ],
    );
  }
}
