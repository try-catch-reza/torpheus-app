import 'package:flutter/material.dart';
import 'package:torpheus/core/constants/extension/string_extension.dart';

import '../../../core/constants/color_constants.dart';

class AvatarCardMobileCustom extends StatelessWidget {
  const AvatarCardMobileCustom({
    super.key,
    required this.title,
    required this.subTitle,
    required this.onTap,
    required this.isActive,
  });

  final String title;
  final String subTitle;
  final VoidCallback onTap;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(bottom: 10, top: 10),
        decoration: BoxDecoration(
          border: Border(
            top: const BorderSide(
              color: ColorConstants.mercury,
              width: 1.0,
            ),
            bottom: const BorderSide(
              color: ColorConstants.mercury,
              width: 1.0,
            ),
            left: BorderSide(
              color: isActive ? Colors.green : Colors.redAccent,
              width: 5.0,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 21,
                    backgroundColor: ColorConstants.chambray,
                    child: Text(
                      title.iniciais,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF111827),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          subTitle,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF6B7280),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    size: 20,
                    Icons.arrow_forward_ios,
                    color: ColorConstants.chambray,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
