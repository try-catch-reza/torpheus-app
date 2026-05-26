import 'package:flutter/material.dart';
import 'package:torpheus/config/routes.dart';

import '../../../../core/constants/custom_colors.dart';

class ClienteMobileHeader extends StatelessWidget {
  const ClienteMobileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Clientes',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1B2A4A),
                decoration: TextDecoration.none,
              ),
            ),
            SizedBox(height: 2),
            Text(
              'Cadastro e histórico de clientes',
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
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                AppRoutes.cadastrarCliente.route,
              );
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
            child: const Icon(Icons.add_rounded, size: 18),
          ),
        ),
      ],
    );
  }
}
