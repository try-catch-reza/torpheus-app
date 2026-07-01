import 'package:flutter/material.dart';
import 'package:torpheus/data/models/servico_model.dart';

import '../../../../core/constants/color_constants.dart';
import '../../../../data/models/foto_model.dart';
import '../../../../domain/repositories/preferenfeces/preferences_local_repository.dart';
import '../../../../injector.dart';

class FotoMobileItemExistente extends StatelessWidget {
  const FotoMobileItemExistente({
    super.key,
    required this.foto,
    required this.servico,
  });

  final FotoModel foto;
  final ServicoModel servico;

  Map<String, String> get _authHeaders => {
        'Authorization':
            'Bearer ${getIt.get<PreferencesLocalRepository>().getAccessToken()}',
      };

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: foto.url != null
              ? Image.network(
                  'http://10.0.2.2:5050${foto.url!}',
                  headers: _authHeaders,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: ColorConstants.mercury,
                    child: const Icon(
                      Icons.broken_image,
                      color: ColorConstants.lightGrey,
                    ),
                  ),
                )
              : Container(
                  color: ColorConstants.mercury,
                  child: const Icon(
                    Icons.image_not_supported,
                    color: ColorConstants.lightGrey,
                  ),
                ),
        ),
        if (foto.url != null)
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
        insetPadding: const EdgeInsets.all(16),
        child: Stack(
          children: [
            InteractiveViewer(
              child: Image.network(
                'http://10.0.2.2:5050${foto.url!}',
                headers: _authHeaders,
                fit: BoxFit.contain,
              ),
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
