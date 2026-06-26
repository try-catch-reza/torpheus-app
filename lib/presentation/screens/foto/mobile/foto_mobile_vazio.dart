import 'package:flutter/material.dart';

import '../../../../core/constants/color_constants.dart';

class FotoMobileVazio extends StatelessWidget {
  const FotoMobileVazio({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.photo_library_outlined,
            size: 80,
            color: ColorConstants.lightGrey,
          ),
          const SizedBox(height: 16),
          Text(
            'Nenhuma foto adicionada',
            style: TextStyle(
              fontSize: 18,
              color: ColorConstants.squant,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Tire uma foto ou selecione da galeria',
            style: TextStyle(
              fontSize: 14,
              color: ColorConstants.lightGrey,
            ),
          ),
        ],
      ),
    );
  }
}
