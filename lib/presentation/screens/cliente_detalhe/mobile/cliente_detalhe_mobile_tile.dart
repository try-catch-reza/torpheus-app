import 'package:flutter/material.dart';
import 'package:torpheus/presentation/components/divider_custom.dart';

import '../../../../core/constants/color_constants.dart';

class ClienteDetalheMobileTile extends StatelessWidget {
  const ClienteDetalheMobileTile({
    super.key,
    required this.title,
    required this.value,
    this.isDivider = true,
  });

  final String title;
  final String value;
  final bool isDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 8),
          dense: true,
          title: Text(
            title,
            style: const TextStyle(
              color: ColorConstants.steel,
              fontSize: 15,
            ),
          ),
          trailing: Text(
            value,
            style: const TextStyle(
              color: ColorConstants.chromaphobicBlack,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        isDivider ? DividerCustom.dividerList : const SizedBox.shrink(),
      ],
    );
  }
}
