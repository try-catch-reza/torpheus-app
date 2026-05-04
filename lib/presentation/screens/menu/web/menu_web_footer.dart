import 'package:flutter/material.dart';
import 'package:torpheus/core/constants/extension/string_extension.dart';

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
        GestureDetector(
          onTap: () {
            // TODO: navegar para configurações
          },
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Icon(
                  Icons.settings_outlined,
                  size: 17,
                  color: Color(0xFF8FA3C0),
                ),
                SizedBox(width: 14),
                Text(
                  'Configurações',
                  style: TextStyle(
                    fontSize: 13,
                    decoration: TextDecoration.none,
                    color: Color(0xFF8FA3C0),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
        const Divider(color: Color(0xFF304D7A), height: 1),
        Padding(
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
                      nomeUsuario,
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
            ],
          ),
        ),
      ],
    );
  }
}
