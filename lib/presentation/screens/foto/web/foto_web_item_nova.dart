import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/constants/color_constants.dart';

class FotoWebItemNova extends StatelessWidget {
  const FotoWebItemNova({
    super.key,
    required this.xFile,
    required this.index,
  });

  final XFile xFile;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: FutureBuilder<dynamic>(
            future: xFile.readAsBytes(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Container(
                  color: ColorConstants.mercury,
                  child: const Center(child: CircularProgressIndicator()),
                );
              }
              return Image.memory(snapshot.data!, fit: BoxFit.cover);
            },
          ),
        ),
        Positioned(
          top: 4,
          left: 4,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.orange.withOpacity(0.85),
              borderRadius: BorderRadius.circular(4),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            child: const Text(
              'Nova',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () => _abrirFotoCompleta(context),
            ),
          ),
        ),
      ],
    );
  }

  void _abrirFotoCompleta(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.black,
        insetPadding: const EdgeInsets.all(32),
        child: Stack(
          children: [
            FutureBuilder<dynamic>(
              future: xFile.readAsBytes(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  );
                }
                return InteractiveViewer(
                  child: Image.memory(snapshot.data!, fit: BoxFit.contain),
                );
              },
            ),
            Positioned(
              top: 8,
              right: 8,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white, size: 28),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
