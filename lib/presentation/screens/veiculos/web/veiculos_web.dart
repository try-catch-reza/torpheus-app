import 'package:flutter/material.dart';

class VeiculosWeb extends StatelessWidget {
  const VeiculosWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Veículos - Web')),
      body: const Center(child: Text('Conteúdo da versão web de Veículos')),
    );
  }
}
