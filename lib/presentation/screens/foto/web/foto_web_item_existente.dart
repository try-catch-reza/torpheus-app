import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/color_constants.dart';
import '../../../../core/constants/enum/status_servico.dart';
import '../../../../data/models/foto_model.dart';
import '../../../../data/models/servico_model.dart';
import '../../../../domain/repositories/preferenfeces/preferences_local_repository.dart';
import '../../../../injector.dart';
import '../bloc/foto_bloc.dart';

class FotoWebItemExistente extends StatelessWidget {
  const FotoWebItemExistente({
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
                  'http://localhost:5050${foto.url!}',
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
        if (servico.statusServico != StatusServico.completado)
          Positioned(
            top: 4,
            right: 4,
            child: GestureDetector(
              onTap: () =>
                  context.read<FotoBloc>().add(FotoRemoverFotoExistente(foto)),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.black54,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(4),
                child:
                    const Icon(Icons.close, color: Colors.white, size: 16),
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
        insetPadding: const EdgeInsets.all(32),
        child: Stack(
          children: [
            InteractiveViewer(
              child: Image.network(
                'http://localhost:5050${foto.url!}',
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
