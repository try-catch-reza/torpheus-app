import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/screens/ordens_servico/bloc/ordens_servico_bloc.dart';
import 'package:torpheus/presentation/screens/servico/bloc/servico_bloc.dart';

import '../../../../core/constants/color_constants.dart';
import '../../../../core/constants/enum/status_ordem.dart';
import '../../../components/dialog/dialog_confirm.dart';

class ServicoWebHeader extends StatelessWidget {
  const ServicoWebHeader({super.key, required this.state});

  final ServicoState state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 24.0,
        top: 10,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              size: 24,
              color: ColorConstants.chambray,
            ),
            onPressed: () {
              context.read<OrdensServicoBloc>().add(const OrdensServicoLoad());
            },
          ),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Serviços',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1B2A4A),
                  decoration: TextDecoration.none,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'Gerencie os serviços da sua ordem de serviço',
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF6B7A99),
                  decoration: TextDecoration.none,
                ),
              ),
            ],
          ),
          const Spacer(),
          Visibility(
            visible: state.ordemServico?.statusOrdem != StatusOrdem.completado,
            child: ElevatedButton.icon(
              onPressed: () {
                ConfirmDialog.show(
                  context,
                  titulo: 'Finalizar ordem de serviço',
                  mensagem:
                      'Tem certeza que deseja finalizar a ordem de serviço? '
                      'Essa ação não poderá ser desfeita.',
                  onConfirmar: () {
                    context.read<ServicoBloc>().add(
                          const ServicoTrocarStatusOS(
                            status: StatusOrdem.completado,
                          ),
                        );
                  },
                );
              },
              label: const Text('Concluir'),
              icon: const Icon(Icons.check),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstants.chambray,
                textStyle: const TextStyle(
                  fontSize: 13,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 18,
                ),
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
