import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/color_constants.dart';
import '../bloc/foto_bloc.dart';

class FotoMobileBottomBar extends StatelessWidget {
  const FotoMobileBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () {
                context.read<FotoBloc>().add(const FotoSelecionarGaleria());
              },
              icon: const Icon(Icons.photo_library_outlined),
              label: const Text('Galeria'),
              style: OutlinedButton.styleFrom(
                foregroundColor: ColorConstants.chambray,
                side: BorderSide(color: ColorConstants.chambray),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                context.read<FotoBloc>().add(const FotoTirarFoto());
              },
              icon: const Icon(Icons.camera_alt_outlined),
              label: const Text('Câmera'),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstants.chambray,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
