import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/screens/cadastrar_funcionario/bloc/cadastrar_funcionario_bloc.dart';

import '../../../components/botao_ativar.dart';

class CadastrarFuncionarioMobileAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  const CadastrarFuncionarioMobileAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CadastrarFuncionarioBloc, CadastrarFuncionarioState>(
      builder: (context, state) {
        return AppBar(
          title: state.funcionario != null
              ? const Text('Atualizar funcionário')
              : const Text('Cadastrar funcionário'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_rounded, size: 18),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: [
            BotaoAtivar(
              isEnabled: state.funcionario != null,
              isActive: state.funcionario?.isActive ?? false,
              onChanged: (value) {
                context.read<CadastrarFuncionarioBloc>().add(
                      CadastrarFuncionarioSetAtivo(),
                    );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
