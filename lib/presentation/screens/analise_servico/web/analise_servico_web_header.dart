import 'package:flutter/material.dart';

import '../../../../core/constants/color_constants.dart';

class AnaliseServicoWebHeader extends StatelessWidget {
  const AnaliseServicoWebHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 24.0,
        top: 10,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              size: 24,
              color: ColorConstants.chambray,
            ),
            onPressed: () {},
          ),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Análise de Serviço',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1B2A4A),
                  decoration: TextDecoration.none,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'Gerencie a análise do serviço da sua ordem de serviço',
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF6B7A99),
                  decoration: TextDecoration.none,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
