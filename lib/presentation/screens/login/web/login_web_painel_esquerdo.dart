import 'package:flutter/material.dart';

import '../../../../core/constants/custom_colors.dart';
import 'login_web_features.dart';
import 'login_web_footer.dart';
import 'login_web_grid.dart';
import '../../../components/web/web_logo_header.dart';

class LoginWebPainelEsquerdo extends StatelessWidget {
  const LoginWebPainelEsquerdo({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.75,
      height: height,
      child: Stack(
        children: [
          Positioned.fill(
            child: ColoredBox(color: ColorConstants.chambray),
          ),
          Positioned.fill(
            child: CustomPaint(painter: LoginWebGrid()),
          ),
           const Padding(
            padding: EdgeInsets.symmetric(horizontal: 64, vertical: 48),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(flex: 1),
                WebLogoHeader(),
                SizedBox(height: 28),
                LoginWebFeatures(),
                Spacer(flex: 2),
                LoginWebFooter(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}