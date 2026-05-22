import 'package:flutter/material.dart';

class MecanicosWebContent extends StatelessWidget {
  const MecanicosWebContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mecânicos - Web')),
      body: const Center(child: Text('Conteúdo da versão web de Mecânicos')),
    );
  }
}
