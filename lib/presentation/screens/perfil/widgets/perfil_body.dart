import 'package:flutter/material.dart';
import 'package:torpheus/core/constants/custom_colors.dart';
import 'package:torpheus/core/constants/extension/string_extension.dart';
import 'package:torpheus/presentation/screens/perfil/bloc/perfil_bloc.dart';
import 'package:torpheus/presentation/screens/perfil/widgets/perfil_info_tile.dart';

class PerfilBody extends StatelessWidget {
  const PerfilBody({super.key, required this.state});

  final PerfilState state;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              CircleAvatar(
                radius: 55,
                backgroundColor: const Color(0xffe9edf3),
                child: Text(
                  state.nome.iniciais,
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                    color: ColorConstants.chambray,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Meu Perfil",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Gerencie suas informações e\nconfigurações da conta",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  children: [
                    PerfilInfoTile(
                      icon: Icons.person,
                      title: "Nome",
                      value: state.nome.primeiraLetraMaiuscula,
                    ),
                    const Divider(),
                    PerfilInfoTile(
                      icon: Icons.email,
                      title: "Email",
                      value: state.email,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              InkWell(
                borderRadius: BorderRadius.circular(24),
                onTap: () => {},
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.logout,
                        color: Colors.red,
                        size: 30,
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Logout",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Sair da conta atual",
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
