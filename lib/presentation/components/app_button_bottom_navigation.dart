import 'package:flutter/material.dart';

import '../../core/constants/color_constants.dart';
import 'app_primary_button.dart';

class AppButtonBottomNavigation extends StatelessWidget {
  const AppButtonBottomNavigation({
    super.key,
    required this.onPressed,
    required this.text,
    required this.icon,
  });

  final VoidCallback onPressed;
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorConstants.chambray,
      child: AppPrimaryButton(
        fontSize: 17,
        text: text,
        icon: icon,
        onPressed: onPressed,
      ),
    );
  }
}
