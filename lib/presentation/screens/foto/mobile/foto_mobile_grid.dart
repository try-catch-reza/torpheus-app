import 'dart:io';

import 'package:flutter/material.dart';
import 'package:torpheus/data/models/servico_model.dart';
import 'package:torpheus/presentation/screens/foto/mobile/foto_mobile_item_existente.dart';

import '../../../../data/models/foto_model.dart';
import 'foto_mobile_item_nova.dart';

class FotoMobileGrid extends StatelessWidget {
  const FotoMobileGrid({
    super.key,
    required this.fotosExistentes,
    required this.fotosNovas,
    required this.servico,
  });

  final List<FotoModel> fotosExistentes;
  final List<File> fotosNovas;
  final ServicoModel servico;

  @override
  Widget build(BuildContext context) {
    final totalFotos = fotosExistentes.length + fotosNovas.length;

    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: totalFotos,
      itemBuilder: (context, index) {
        if (index < fotosExistentes.length) {
          return FotoMobileItemExistente(
            foto: fotosExistentes[index],
            servico: servico,
          );
        }

        final localIndex = index - fotosExistentes.length;

        return FotoMobileItemNova(
          file: fotosNovas[localIndex],
          index: localIndex,
        );
      },
    );
  }
}
