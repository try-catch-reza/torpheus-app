import 'package:flutter/material.dart';

import '../../../../core/shared/app_system_info.dart';

class LoginWebFooter extends StatelessWidget {
  const LoginWebFooter({super.key});

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(
      fontSize: 11,
      color: Color(0xFF8FA3C0),
      letterSpacing: 0.5,
    );
    const dot =
        Text(' • ', style: TextStyle(fontSize: 11, color: Color(0xFF4A5E7A)));

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${AppSystemInfo.appInfo?.appVersionInfo.appVersionName} - '
          '${AppSystemInfo.appInfo?.appVersionInfo.appVersionCode} ·  ',
          style: style,
        ),
        dot,
        const Text('UniSenai Chapecó', style: style),
        dot,
        const Text('2026', style: style),
      ],
    );
  }
}
