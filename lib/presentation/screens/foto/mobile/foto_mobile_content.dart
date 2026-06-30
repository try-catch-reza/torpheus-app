import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/core/constants/enum/status_servico.dart';
import 'package:torpheus/presentation/components/app_bar_padrao.dart';
import 'package:torpheus/presentation/components/loading_state.dart';
import 'package:torpheus/presentation/screens/foto/mobile/foto_mobile_bottom_bar.dart';
import 'package:torpheus/presentation/screens/foto/mobile/foto_mobile_grid.dart';

import '../../../../core/constants/color_constants.dart';
import '../../../../data/models/servico_model.dart';
import '../bloc/foto_bloc.dart';
import 'foto_mobile_upload_button.dart';
import 'foto_mobile_vazio.dart';

class FotoMobileContent extends StatelessWidget {
  const FotoMobileContent({
    super.key,
    required this.ordemServicoId,
    required this.servico,
  });

  final String ordemServicoId;
  final ServicoModel servico;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.corFundo,
      appBar: AppBarPadrao(
        title: servico.descricao != null && servico.descricao!.length > 30
            ? '${servico.descricao!.substring(0, 30)}...'
            : servico.descricao ?? 'Fotos',
        hasLeading: true,
      ),
      body: BlocConsumer<FotoBloc, FotoState>(
        listener: _listener,
        builder: (context, state) {
          final totalFotos =
              state.fotosExistentes.length + state.fotosNovas.length;

          if (state is FotoLoading) {
            return const LoadingState();
          }

          if (totalFotos == 0) {
            return const FotoMobileVazio();
          }

          return FotoMobileGrid(
            fotosExistentes: state.fotosExistentes,
            fotosNovas: state.fotosNovas,
            servico: servico,
          );
        },
      ),
      bottomNavigationBar: Visibility(
        visible: servico.statusServico != StatusServico.completado &&
            servico.statusServico != StatusServico.cancelado,
        child: const FotoMobileBottomBar(),
      ),
      floatingActionButton: FotoMobileUploadButton(
        ordemServicoId: ordemServicoId,
        servicoId: servico.id ?? '',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
