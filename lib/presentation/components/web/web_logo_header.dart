import 'package:flutter/material.dart';

import '../../../core/constants/assets_contants.dart';

class WebLogoHeader extends StatelessWidget {
  const WebLogoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            AssetsConstants.logo,
            width: MediaQuery.of(context).size.width * 0.3,
            height: MediaQuery.of(context).size.height * 0.3,
          ),
        ),
        const Text(
          'Sistema de Gestão de Oficina Mecânica',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: Color(0xFF8FA3C0),
            letterSpacing: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
