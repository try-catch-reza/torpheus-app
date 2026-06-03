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
  });

  final VoidCallback onPressed;
  final String title;
  final String subtitle;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Container(
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
            ),
            SearchCustom(
              controller: controller,
              width: double.infinity,
              onChanged: onChanged,
              hintText: hintText,
            ),
          ],
        ),
      ),
    );
  }
}
