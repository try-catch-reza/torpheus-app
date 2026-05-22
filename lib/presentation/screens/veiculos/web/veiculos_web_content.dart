import 'package:flutter/material.dart';

class VeiculosWebContent extends StatelessWidget {
  const VeiculosWebContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Veículos - Web')),
      body: const Center(child: Text('Conteúdo Web de Veículos')),
    );
  }
}
