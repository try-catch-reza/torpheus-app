import 'package:flutter/material.dart';
import 'package:torpheus/core/constants/color_constants.dart';
import 'package:torpheus/data/models/permissao_model.dart';

class PerfisItemPermissao extends StatelessWidget {
  const PerfisItemPermissao({super.key, required this.permissao});

  final PermissaoModel permissao;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('Permissao: $permissao');
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: 40,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: ColorConstants.zhenZhuBaiPearl,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: ColorConstants.mercury),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 18,
              height: 18,
              child: Checkbox(
                onChanged: (value) {},
                value: permissao.isSelected,
                activeColor: ColorConstants.chambray,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
                side: const BorderSide(
                  color: ColorConstants.mercury,
                  width: 1.5,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  permissao.titulo,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 1),
                Text(
                  permissao.acao,
                  style: const TextStyle(
                    fontSize: 10,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 6),
            // PermissionBadge(action: permission.action),
          ],
        ),
      ),
    );
  }
}
