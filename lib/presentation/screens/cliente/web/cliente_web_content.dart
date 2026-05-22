import 'package:flutter/material.dart';

class ClienteWebContent extends StatelessWidget {
  const ClienteWebContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Clientes - Web')),
      body: const Center(child: Text('Conteúdo da versão web de Clientes')),
    );
  }
}
