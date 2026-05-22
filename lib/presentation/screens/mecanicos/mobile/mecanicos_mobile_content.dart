import 'package:flutter/material.dart';

class MecanicosMobileContent extends StatelessWidget {
  const MecanicosMobileContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mecânicos - Mobile')),
      body: const Center(child: Text('Conteúdo da versão mobile de Mecânicos')),
    );
  }
}
