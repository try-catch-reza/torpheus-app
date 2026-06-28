import 'package:flutter/material.dart';
import 'package:torpheus/core/constants/extension/int_extension.dart';
import 'package:torpheus/core/constants/extension/string_extension.dart';
import 'package:torpheus/presentation/screens/analise_servico/bloc/analise_servico_bloc.dart';

import '../../../../core/constants/color_constants.dart';
import '../../../components/divider_custom.dart';

class AnaliseServicoMobileRegistros extends StatelessWidget {
  const AnaliseServicoMobileRegistros({super.key, required this.state});

  final AnaliseServicoState state;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorConstants.mercury,
          width: 1.0,
        ),
        color: Colors.white,
      ),
      child: Expanded(
        child: ListView.separated(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: state.servico?.registroTrabalho?.length ?? 0,
          separatorBuilder: (context, index) => DividerCustom.dividerList,
          itemBuilder: (context, index) {
            final registro = state.servico?.registroTrabalho![index];

            return Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: ColorConstants.mercury,
                    width: 1.0,
                  ),
                  bottom: BorderSide(
                    color: ColorConstants.mercury,
                    width: 1.0,
                  ),
                ),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                dense: true,
                title: Text(
                  registro?.funcionarioNome ?? '',
                  style: const TextStyle(
                    color: ColorConstants.steel,
                    fontSize: 15,
                  ),
                ),
                subtitle: Text(
                  registro?.note ?? '',
                ),
                trailing: Text(
                  'Realizada: ${registro?.performedAt.toString().formataData}'
                   '\nDuração: ${registro?.durationMinutes?.toHourMinute ?? ''}',
                  style: const TextStyle(
                    color: ColorConstants.steel,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
