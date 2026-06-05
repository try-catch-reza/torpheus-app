import 'package:flutter/material.dart';
import 'package:torpheus/core/constants/extension/string_extension.dart';
import '../../../../core/constants/color_constants.dart';
import '../../../../data/models/usuario_model.dart';

class UsuarioMobileCard extends StatelessWidget {
  const UsuarioMobileCard({
    super.key,
    required this.usuario,
    required this.onEdit,
    required this.onTap,
  });

  final UsuarioModel usuario;
  final VoidCallback onEdit;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(bottom: 10, top: 10),
        decoration: BoxDecoration(
          border: Border.all(
            color: ColorConstants.mercury,
            width: 1.0,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 21,
                    backgroundColor: ColorConstants.chambray,
                    child: Text(
                      usuario.nome?.iniciais ?? '',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          usuario.nome ?? '',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF111827),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          usuario.email ?? '',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF6B7280),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    size: 20,
                    Icons.arrow_forward_ios,
                    color: ColorConstants.chambray,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
