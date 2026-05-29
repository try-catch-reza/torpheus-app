import 'package:flutter/material.dart';

class MecanicoWebTableHeader extends StatelessWidget {
  const MecanicoWebTableHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: const Color(0xFFF8FAFC),
      child: const Row(
        children: [
          Expanded(
              flex: 4,
              child:
                  Text('Nome', style: TextStyle(fontWeight: FontWeight.w600))),
          Expanded(
              flex: 3,
              child:
                  Text('CREP', style: TextStyle(fontWeight: FontWeight.w600))),
          Expanded(
              flex: 3,
              child: Text('Telefone',
                  style: TextStyle(fontWeight: FontWeight.w600))),
          Expanded(
              flex: 4,
              child:
                  Text('Email', style: TextStyle(fontWeight: FontWeight.w600))),
          SizedBox(width: 32),
        ],
      ),
    );
  }
}
