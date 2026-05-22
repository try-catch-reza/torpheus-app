import 'package:flutter/material.dart';

class ClienteMobileContent extends StatelessWidget {
  const ClienteMobileContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Clientes - Mobile')),
      body: const Center(child: Text('Conteúdo da versão mobile de Clientes')),
    );
  }
}
