import 'package:flutter/material.dart';
import 'package:torpheus/data/models/permissao_grupo_model.dart';
import 'package:torpheus/presentation/screens/perfis/mobile/perfis_mobile_permissao_card.dart';

class PerfisMobileCard extends StatelessWidget {
  const PerfisMobileCard({super.key, required this.grupo});

  final PermissaoGrupoModel grupo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              grupo.titulo.toUpperCase(),
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Color(0xFF9A9A96),
                letterSpacing: 0.6,
              ),
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: grupo.itens.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 2.8,
            ),
            itemBuilder: (context, index) {
              final permissao = grupo.itens[index];

              return PerfisMobilePermissaoCard(permissao: permissao);
            },
          ),
        ],
      ),
    );
  }
}
