import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/screens/mecanicos/bloc/mecanicos_bloc.dart';

import '../../../../core/constants/custom_colors.dart';

class MecanicoWebHeader extends StatelessWidget {
  const MecanicoWebHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Mecânicos',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1B2A4A),
                decoration: TextDecoration.none,
              ),
            ),
            SizedBox(height: 2),
            Text(
              'Cadastro e histórico de mecânicos',
              style: TextStyle(
                fontSize: 13,
                color: Color(0xFF6B7A99),
                decoration: TextDecoration.none,
              ),
            ),
          ],
        ),
        const Spacer(),
        SizedBox(
          height: 40,
          child: ElevatedButton.icon(
            onPressed: () {
              context.read<FuncionarioBloc>().add(const MecanicosCadastrar());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorConstants.chambray,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            icon: const Icon(Icons.add_rounded, size: 18),
            label: const Text(
              'Cadastrar mecânico',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
