import 'package:flutter/material.dart';
import 'package:torpheus/core/constants/color_constants.dart';
import 'package:torpheus/data/models/perfis_model.dart';

class PerfisWebHeader extends StatelessWidget {
  const PerfisWebHeader({super.key, required this.perfis});

  final PerfisModel? perfis;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: ColorConstants.zhenZhuBaiPearl,
        border: Border(bottom: BorderSide(color: ColorConstants.mercury)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.shield_outlined,
                size: 20,
                color: ColorConstants.chambray,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              perfis?.nome ?? '',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
