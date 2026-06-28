import 'package:flutter/material.dart';
import 'package:torpheus/core/constants/extension/string_extension.dart';

class HeaderUsuario extends StatelessWidget {
  const HeaderUsuario({
    super.key,
    required this.nomeUsuario,
    required this.emailUsuario,
    this.onTap,
  });

  final String nomeUsuario;
  final String emailUsuario;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: const Color(0xFF253A60),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: const Color(0xFF304D7A),
                  width: 1.5,
                ),
              ),
              child: Center(
                child: Text(
                  nomeUsuario.iniciais,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),
            Text(
              nomeUsuario.primeiraLetraMaiuscula,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                decoration: TextDecoration.none,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text(
              emailUsuario,
              style: const TextStyle(
                fontSize: 11,
                color: Color(0xFF6B7A99),
                decoration: TextDecoration.none,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}