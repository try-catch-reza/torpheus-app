import 'package:flutter/material.dart';
import 'package:torpheus/presentation/components/mobile/avatar_card_mobile_custom.dart';
import '../../../../data/models/usuario_model.dart';

class UsuarioMobileLista extends StatelessWidget {
  const UsuarioMobileLista({
    super.key,
    required this.usuarios,
  });

  final List<UsuarioModel> usuarios;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: usuarios.length,
        itemBuilder: (context, index) {
          final usuario = usuarios[index];

          return AvatarCardMobileCustom(
            title: usuario.nome ?? '',
            subTitle: usuario.email ?? '',
            isActive: usuario.isActive ?? false,
          );
        },
      ),
    );
  }
}
