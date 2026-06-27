import 'package:flutter/material.dart';
import 'package:torpheus/core/constants/color_constants.dart';
import 'package:torpheus/data/models/permissao_grupo_model.dart';
import 'package:torpheus/presentation/screens/perfis/web/perfis_web_item_permissao.dart';

class PerfisWebPermissionCard extends StatelessWidget {
  const PerfisWebPermissionCard({
    super.key,
    required this.grupo,
    required this.hasEditarPerfis,
  });

  final PermissaoGrupoModel grupo;
  final bool hasEditarPerfis;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ColorConstants.mercury),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: ColorConstants.mercury)),
            ),
            child: Text(
              grupo.titulo,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final crossAxisCount = constraints.maxWidth > 500 ? 3 : 1;
                final childAspectRadio = constraints.maxWidth > 800 ? 5.0 : 2.0;
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: childAspectRadio,
                  ),
                  itemCount: grupo.itens.length,
                  itemBuilder: (context, index) {
                    final permission = grupo.itens[index];

                    return PerfisWebItemPermissao(
                      permissao: permission,
                      hasAtualizarPerfis: hasEditarPerfis,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
