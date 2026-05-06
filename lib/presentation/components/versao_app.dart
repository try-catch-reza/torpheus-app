import 'package:flutter/material.dart';

import '../../core/shared/app_system_info.dart';

class VersaoApp extends StatelessWidget {
  const VersaoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        '${AppSystemInfo.appInfo?.appVersionInfo.appVersionName} - '
        '${AppSystemInfo.appInfo?.appVersionInfo.appVersionCode} ·  '
        'UniSenai Chapecó  ·  2026',
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 14,
          color: Color(0xFF9BAABB),
          letterSpacing: 0.4,
          decoration: TextDecoration.none,
        ),
      ),
    );
  }
}
