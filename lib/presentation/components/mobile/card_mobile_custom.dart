import 'package:flutter/material.dart';

import '../../../core/constants/color_constants.dart';

class CardMobileCustom extends StatelessWidget {
  const CardMobileCustom({
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
              Padding(
                padding: const EdgeInsets.only(left: 2.0),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                    color: ColorConstants.chromaphobicBlack,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 6.0,
                        right: 20.0,
                      ),
                      child: Text(
                        subTitle,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: const TextStyle(
                          fontSize: 13.0,
                          color: ColorConstants.shadowMountain,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 18.0,
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
