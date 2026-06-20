import 'package:flutter/material.dart';

import '../../../core/constants/color_constants.dart';
import '../search_custom.dart';
import 'header_mobile_custom.dart';

class AppBarMobileSearch extends StatelessWidget {
  const AppBarMobileSearch({
    super.key,
    required this.onPressed,
    required this.title,
    required this.subtitle,
    required this.controller,
    this.onChanged,
    this.hintText = 'Pesquisar por nome',
    this.hasPodeCriar = false,
    this.hasPopUp = true,
  });

  final VoidCallback onPressed;
  final String title;
  final String subtitle;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final String hintText;
  final bool hasPodeCriar;
  final bool hasPopUp;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorConstants.zhenZhuBaiPearl,
        border: Border.all(color: ColorConstants.mercury, width: 2.0),
      ),
      child: Column(
        children: [
          HeaderMobileCustom(
            title: title,
            subtitle: subtitle,
            onPressed: onPressed,
            hasPodeCriar: hasPodeCriar,
            hasPopUp: hasPopUp,
          ),
          SearchCustom(
            controller: controller,
            width: double.infinity,
            onChanged: onChanged,
            hintText: hintText,
          ),
        ],
      ),
    );
  }
}
