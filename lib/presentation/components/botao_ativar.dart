import 'package:flutter/material.dart';

import '../../core/constants/color_constants.dart';

class BotaoAtivar extends StatelessWidget {
  const BotaoAtivar({
    super.key,
    required this.isEnabled,
    required this.isActive,
    required this.onChanged,
  });

  final bool isEnabled;
  final bool isActive;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isEnabled,
      child: Row(
        children: [
          Text(
            isActive ? 'Ativo' : 'Inativo',
            style: const TextStyle(fontSize: 17),
          ),
          Switch(
            value: isActive,
            onChanged: onChanged,
            activeColor: ColorConstants.activeThumb,
            activeTrackColor: ColorConstants.activeBorder,
            inactiveThumbColor: ColorConstants.inactiveThumb,
            inactiveTrackColor: ColorConstants.inactiveBorder,
          ),
        ],
      ),
    );
  }
}
