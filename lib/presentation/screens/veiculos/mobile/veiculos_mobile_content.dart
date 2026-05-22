import 'package:flutter/material.dart';

class VeiculosMobileContent extends StatelessWidget {
  const VeiculosMobileContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Veículos - Mobile')),
      body: const Center(child: Text('Conteúdo Mobile de Veículos')),
    );
  }
}
