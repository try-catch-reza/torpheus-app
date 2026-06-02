import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/screens/cadastrar_cliente/bloc/cadastrar_cliente_bloc.dart';

class CadastrarClienteMobileAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const CadastrarClienteMobileAppBar({super.key});

  static const _activeBorder = Color(0xFF6EE7B7);
  static const _activeThumb = Color(0xFF065F46);

  static const _inactiveBorder = Color(0xFFFCA5A5);
  static const _inactiveThumb = Color(0xFF991B1B);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CadastrarClienteBloc, CadastrarClienteState>(
      builder: (context, state) {
        return AppBar(
          title: state.isEdit
              ? const Text('Atualizar Cliente')
              : const Text('Cadastrar Cliente'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_rounded, size: 18),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: [
            Visibility(
              visible: state.isEdit,
              child: Row(
                children: [
                  Text(
                    state.clienteEditar.isActive ?? false ? 'Ativo' : 'Inativo',
                    style: const TextStyle(fontSize: 17),
                  ),
                  Switch(
                    value: state.clienteEditar.isActive ?? false,
                    onChanged: (value) {
                      context.read<CadastrarClienteBloc>().add(
                            CadastrarClienteSetAtivo(value),
                          );
                    },
                    activeColor: _activeThumb,
                    activeTrackColor: _activeBorder,
                    inactiveThumbColor: _inactiveThumb,
                    inactiveTrackColor: _inactiveBorder,
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
