import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/core/constants/color_constants.dart';
import 'package:torpheus/data/models/foto_model.dart';
import 'package:torpheus/data/models/servico_model.dart';
import 'package:torpheus/presentation/screens/foto/bloc/foto_bloc.dart';
import 'package:torpheus/presentation/screens/foto/web/foto_web_item_existente.dart';
import 'package:torpheus/presentation/screens/foto/web/foto_web_item_nova.dart';

class FotoWebContent extends StatelessWidget {
  const FotoWebContent({
    super.key,
    required this.ordemServicoId,
    required this.servico,
  });

  final String ordemServicoId;
  final ServicoModel servico;

  static void show(
    BuildContext context, {
    required FotoBloc fotoBloc,
    required String ordemServicoId,
    required ServicoModel servico,
  }) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => BlocProvider.value(
        value: fotoBloc
          ..add(FotoCarregar(fotosExistentes: servico.fotos ?? [])),
        child: FotoWebContent(
          ordemServicoId: ordemServicoId,
          servico: servico,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 48, vertical: 32),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800, maxHeight: 700),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _FotoWebHeader(servico: servico),
            const Divider(height: 1, color: Color(0xFFEEF0F3)),
            Expanded(
              child: BlocConsumer<FotoBloc, FotoState>(
                listener: _listener,
                builder: (context, state) {
                  if (state is FotoLoading || state is FotoUploadLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final totalFotos = state.fotosExistentes.length +
                      state.fotosNovas.length +
                      state.fotosNovasWeb.length;

                  if (totalFotos == 0) {
                    return const _FotoWebVazio();
                  }

                  return _FotoWebGrid(
                    fotosExistentes: state.fotosExistentes,
                    fotosNovasWeb: state.fotosNovasWeb,
                    servico: servico,
                  );
                },
              ),
            ),
            const Divider(height: 1, color: Color(0xFFEEF0F3)),
            _FotoWebFooter(
              ordemServicoId: ordemServicoId,
              servicoId: servico.id ?? '',
            ),
          ],
        ),
      ),
    );
  }

  void _listener(BuildContext context, FotoState state) {
    if (state is FotoFail) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.message),
          backgroundColor: ColorConstants.redDelete,
        ),
      );
    }
    if (state is FotoUploadSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Fotos enviadas com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.of(context).pop();
    }
  }
}

class _FotoWebHeader extends StatelessWidget {
  const _FotoWebHeader({required this.servico});

  final ServicoModel servico;

  @override
  Widget build(BuildContext context) {
    final titulo = servico.descricao != null && servico.descricao!.length > 50
        ? '${servico.descricao!.substring(0, 50)}...'
        : servico.descricao ?? 'Fotos';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Icon(Icons.photo_library_outlined,
              color: ColorConstants.chambray, size: 22),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A2332),
                  ),
                ),
                BlocBuilder<FotoBloc, FotoState>(
                  builder: (context, state) {
                    final total = state.fotosExistentes.length +
                        state.fotosNovas.length +
                        state.fotosNovasWeb.length;
                    return Text(
                      '$total foto${total != 1 ? 's' : ''}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF6B7A99),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, color: Color(0xFF6B7A99)),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}

class _FotoWebVazio extends StatelessWidget {
  const _FotoWebVazio();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.add_photo_alternate_outlined,
            size: 64,
            color: ColorConstants.lightGrey,
          ),
          const SizedBox(height: 12),
          Text(
            'Nenhuma foto adicionada',
            style: TextStyle(
              fontSize: 16,
              color: ColorConstants.squant,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Clique em "Selecionar imagens" para adicionar fotos',
            style: TextStyle(fontSize: 13, color: ColorConstants.lightGrey),
          ),
        ],
      ),
    );
  }
}

class _FotoWebGrid extends StatelessWidget {
  const _FotoWebGrid({
    required this.fotosExistentes,
    required this.fotosNovasWeb,
    required this.servico,
  });

  final List<FotoModel> fotosExistentes;
  final List<dynamic> fotosNovasWeb;
  final ServicoModel servico;

  @override
  Widget build(BuildContext context) {
    final total = fotosExistentes.length + fotosNovasWeb.length;

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: total,
      itemBuilder: (context, index) {
        if (index < fotosExistentes.length) {
          return FotoWebItemExistente(
            foto: fotosExistentes[index],
            servico: servico,
          );
        }
        final localIndex = index - fotosExistentes.length;
        return FotoWebItemNova(
          xFile: fotosNovasWeb[localIndex],
          index: localIndex,
        );
      },
    );
  }
}

class _FotoWebFooter extends StatelessWidget {
  const _FotoWebFooter({
    required this.ordemServicoId,
    required this.servicoId,
  });

  final String ordemServicoId;
  final String servicoId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: BlocBuilder<FotoBloc, FotoState>(
        builder: (context, state) {
          final qtdNovas = state.fotosNovasWeb.length + state.fotosNovas.length;
          final isUploading = state is FotoUploadLoading;

          return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton.icon(
                onPressed: isUploading
                    ? null
                    : () => context
                        .read<FotoBloc>()
                        .add(const FotoAdicionarArquivosWeb()),
                icon: const Icon(Icons.add_photo_alternate_outlined),
                label: const Text('Selecionar imagens'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: ColorConstants.chambray,
                  side: BorderSide(color: ColorConstants.chambray),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              if (qtdNovas > 0) ...[
                const SizedBox(width: 12),
                ElevatedButton.icon(
                  onPressed: isUploading
                      ? null
                      : () => context.read<FotoBloc>().add(
                            FotoEnviarFotos(
                              ordemServicoId: ordemServicoId,
                              servicoId: servicoId,
                            ),
                          ),
                  icon: isUploading
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(Icons.cloud_upload_outlined),
                  label: Text(
                    isUploading
                        ? 'Enviando...'
                        : 'Enviar ${qtdNovas == 1 ? '1 foto' : '$qtdNovas fotos'}',
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstants.chambray,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}
