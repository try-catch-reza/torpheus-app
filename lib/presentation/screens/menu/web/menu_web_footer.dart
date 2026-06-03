import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/config/routes.dart';
import 'package:torpheus/core/constants/color_constants.dart';
import 'package:torpheus/core/constants/extension/string_extension.dart';
import 'package:torpheus/presentation/components/dialog/dialog_confirm.dart';

import '../../login/bloc/login_bloc.dart';

class MenuWebFooter extends StatelessWidget {
  const MenuWebFooter({
    super.key,
    required this.nomeUsuario,
    required this.cargoUsuario,
  });

  final String nomeUsuario;
  final String cargoUsuario;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(color: Color(0xFF304D7A), height: 1),
        Material(
          color: ColorConstants.chambray,
          child: PopupMenuButton<String>(
            offset: const Offset(0, -180),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: Color(0xFF304D7A), width: 0.5),
            ),
            color: const Color(0xFF1E3456),
            elevation: 8,
            onSelected: (value) {
              if (value == 'sair') _onTapLogout(context);
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem<String>(
                  enabled: false,
                  padding: EdgeInsets.zero,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom:
                            BorderSide(color: Color(0xFF304D7A), width: 0.5),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            color: const Color(0xFF253A60),
                            borderRadius: BorderRadius.circular(9),
                            border: Border.all(color: const Color(0xFF4A6FA5)),
                          ),
                          child: Center(
                            child: Text(
                              nomeUsuario.iniciais,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: 0.5,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                nomeUsuario.primeiraLetraMaiuscula,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  decoration: TextDecoration.none,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                cargoUsuario,
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: Color(0xFF8FA3C0),
                                  decoration: TextDecoration.none,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'sair',
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: Row(
                    children: [
                      Icon(
                        Icons.logout_rounded,
                        size: 16,
                        color: Color(0xFFE07070),
                      ),
                      SizedBox(width: 12),
                      Text(
                        'Sair da conta',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFFE07070),
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ];
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 20),
              child: Row(
                children: [
                  Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: const Color(0xFF253A60),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFF304D7A)),
                    ),
                    child: Center(
                      child: Text(
                        nomeUsuario.iniciais,
                        style: const TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          nomeUsuario.primeiraLetraMaiuscula,
                          style: const TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          cargoUsuario,
                          style: const TextStyle(
                            fontSize: 11,
                            decoration: TextDecoration.none,
                            color: Color(0xFF8FA3C0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.unfold_more_rounded,
                    size: 16,
                    color: Color(0xFF8FA3C0),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _onTapLogout(BuildContext context) {
    ConfirmDialog.show(
      context,
      titulo: 'Sair do Aplicativo',
      mensagem: 'Tem certeza que deseja sair do aplicativo?',
      onConfirmar: () {
        context.read<LoginBloc>().add(const LoginLogout());
        Navigator.of(context).pushReplacementNamed(AppRoutes.root.route);
      },
    );
  }
}
