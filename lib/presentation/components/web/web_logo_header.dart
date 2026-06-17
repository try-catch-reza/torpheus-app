import 'package:flutter/material.dart';

import '../../../core/constants/assets_contants.dart';

class WebLogoHeader extends StatelessWidget {
  const WebLogoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AssetsConstants.logoSemFundo,
      height: MediaQuery.of(context).size.height * 0.8,
    );
  }
}
