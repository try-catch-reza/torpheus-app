import 'package:flutter/material.dart';

class VeiculosMobile extends StatelessWidget {
  const VeiculosMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Veículos - Mobile')),
      body: const Center(child: Text('Conteúdo da versão mobile de Veículos')),
    );
  }
}
