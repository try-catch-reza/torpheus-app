import 'package:flutter/material.dart';
import 'package:torpheus/presentation/screens/painel/bloc/painel_bloc.dart';
import 'package:torpheus/presentation/screens/painel/web/painel_web_dashboard.dart';
import 'package:torpheus/presentation/screens/painel/widgets/painel_title.dart';

import '../../../../core/constants/color_constants.dart';
import '../mobile/painel_mobile_ativas.dart';

class PainelWebBody extends StatelessWidget {
  const PainelWebBody({super.key, required this.state});

  final PainelState state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 24.0,
          left: 20,
          right: 20,
          top: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PainelTitle(),
            const SizedBox(height: 24),
            PainelWebDashboard(state: state),
            const SizedBox(height: 24),
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
      ),
    );
  }
}
