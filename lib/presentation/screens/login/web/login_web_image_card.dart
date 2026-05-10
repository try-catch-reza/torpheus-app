import 'package:flutter/material.dart';
import 'package:torpheus/core/constants/assets_contants.dart';

class LoginWebImageCard extends StatelessWidget {
  const LoginWebImageCard({super.key, this.imageUrl});

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 180,
      constraints: const BoxConstraints(maxWidth: 420),
      decoration: BoxDecoration(
        color: const Color(0xFF253A60),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF304D7A)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(AssetsConstants.logoTransparente),
      ),
    );
  }
}
