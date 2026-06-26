import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/color_constants.dart';
import '../bloc/foto_bloc.dart';

class FotoMobileUploadButton extends StatelessWidget {
  const FotoMobileUploadButton({
    super.key,
    required this.ordemServicoId,
    required this.servicoId,
  });

  final String ordemServicoId;
  final String servicoId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FotoBloc, FotoState>(
      buildWhen: (prev, curr) =>
          prev.fotosNovas.length != curr.fotosNovas.length ||
          prev.fotosNovasWeb.length != curr.fotosNovasWeb.length ||
          prev is FotoUploadLoading != curr is FotoUploadLoading,
      builder: (context, state) {
        final qtd = state.fotosNovas.length + state.fotosNovasWeb.length;

        if (qtd == 0) return const SizedBox.shrink();

        final isUploading = state is FotoUploadLoading;

        return FloatingActionButton.extended(
          onPressed: isUploading
              ? null
              : () {
                  context.read<FotoBloc>().add(
                        FotoEnviarFotos(
                          ordemServicoId: ordemServicoId,
                          servicoId: servicoId,
                        ),
                      );
                },
          backgroundColor:
              isUploading ? ColorConstants.lightGrey : ColorConstants.chambray,
          foregroundColor: Colors.white,
          elevation: 4,
          icon: isUploading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : const Icon(Icons.cloud_upload_outlined),
          label: Text(
            isUploading
                ? 'Enviando...'
                : 'Enviar ${qtd == 1 ? '1 foto' : '$qtd fotos'}',
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
        );
      },
    );
  }
}
