import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/screens/mecanicos/bloc/mecanicos_bloc.dart';

class CadastrarMecanicoWebHeader extends StatelessWidget {
  const CadastrarMecanicoWebHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => context.read<FuncionarioBloc>().add(const MecanicosLoad()),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.chevron_left_rounded,
                size: 18,
                color: Color(0xFF6B7A99),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cadastrar Funcionário',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1B2A4A),
                decoration: TextDecoration.none,
              ),
            ),
            SizedBox(height: 2),
            Text(
              'Preencha os dados para cadastrar um novo funcionário',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF9BAABB),
                decoration: TextDecoration.none,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
