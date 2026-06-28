import 'package:flutter/material.dart';
import 'package:torpheus/presentation/screens/painel/bloc/painel_bloc.dart';
import 'package:torpheus/presentation/screens/painel/mobile/painel_mobile_ativas.dart';
import 'package:torpheus/presentation/screens/painel/mobile/painel_mobile_cards.dart';

import '../../../../core/constants/color_constants.dart';
import '../widgets/painel_title.dart';

class PainelMobileBody extends StatelessWidget {
  const PainelMobileBody({super.key, required this.state});

  final PainelState state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          const PainelTitle(),
          const SizedBox(height: 16),
          PainelMobileCards(state: state),
          const SizedBox(height: 16),
          Text(
            'Ativas',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: ColorConstants.chambray,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            'Lista de ordens ativas',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade500,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 16),
          PainelMobileAtivas(state: state),
        ],
      ),
    );
  }
}
