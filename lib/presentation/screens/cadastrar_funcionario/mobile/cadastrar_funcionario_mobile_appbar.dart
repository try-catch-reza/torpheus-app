import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/screens/cadastrar_funcionario/bloc/cadastrar_funcionario_bloc.dart';

import '../../../../core/constants/color_constants.dart';

class CadastrarFuncionarioMobileAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  const CadastrarFuncionarioMobileAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CadastrarFuncionarioBloc, CadastrarFuncionarioState>(
      builder: (context, state) {
        return AppBar(
          title: state.funcionario != null
              ? const Text('Atualizar Cliente')
              : const Text('Cadastrar Cliente'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_rounded, size: 18),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: [
            Visibility(
              visible: state.funcionario != null,
              child: Row(
                children: [
                  Text(
                    state.funcionario?.isActive ?? false ? 'Ativo' : 'Inativo',
                    style: const TextStyle(fontSize: 17),
                  ),
                  Switch(
                    value: state.funcionario?.isActive ?? false,
                    onChanged: (value) {
                      context.read<CadastrarFuncionarioBloc>().add(
                            CadastrarFuncionarioSetAtivo(),
                          );
                    },
                    activeColor: ColorConstants.activeThumb,
                    activeTrackColor: ColorConstants.activeBorder,
                    inactiveThumbColor: ColorConstants.inactiveThumb,
                    inactiveTrackColor: ColorConstants.inactiveBorder,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
