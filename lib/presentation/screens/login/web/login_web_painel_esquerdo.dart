import 'package:flutter/material.dart';

import '../../../../core/constants/assets_contants.dart';
import '../../../../core/constants/color_constants.dart';
import 'login_web_footer.dart';

class LoginWebPainelEsquerdo extends StatelessWidget {
  const LoginWebPainelEsquerdo({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.70,
      height: height,
      child: Stack(
        children: [
          Positioned.fill(
            child: ColoredBox(color: ColorConstants.chambray),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 48),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(flex: 1),
                Image.asset(
                  AssetsConstants.logoSemFundo,
                  height: MediaQuery.of(context).size.height * 0.8,
                ),
                const Spacer(flex: 2),
                const LoginWebFooter(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
