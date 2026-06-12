import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/screens/cadastrar_cliente/bloc/cadastrar_cliente_bloc.dart';

import '../../../../core/constants/color_constants.dart';

class CadastrarClienteMobileAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const CadastrarClienteMobileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CadastrarClienteBloc, CadastrarClienteState>(
      builder: (context, state) {
        return AppBar(
          title: state.clienteEditar != null
              ? const Text('Atualizar Cliente')
              : const Text('Cadastrar Cliente'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_rounded, size: 18),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: [
            Visibility(
              visible: state.clienteEditar != null,
              child: Row(
                children: [
                  Text(
                    state.clienteEditar?.isActive ?? false
                        ? 'Ativo'
                        : 'Inativo',
                    style: const TextStyle(fontSize: 17),
                  ),
                  Switch(
                    value: state.clienteEditar?.isActive ?? false,
                    onChanged: (value) {
                      context.read<CadastrarClienteBloc>().add(
                            CadastrarClienteSetAtivo(value),
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
