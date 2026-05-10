import 'package:flutter/material.dart';
import 'package:torpheus/core/constants/assets_contants.dart';

class MobileLogoHeader extends StatelessWidget {
  const MobileLogoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height * 0.04,
        top: MediaQuery.of(context).size.height * 0.04,
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              AssetsConstants.logo,
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.18,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Gestão de Oficina Mecânica',
            style: TextStyle(
              fontSize: 11,
              color: Color(0xFF8FA3C0),
              letterSpacing: 1.2,
              decoration: TextDecoration.none,
            ),
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }
}
