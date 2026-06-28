import 'package:flutter/material.dart';

class RelatorioWebHeader extends StatelessWidget {
  const RelatorioWebHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Relatórios',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: Color(
                  0xFF1B2A4A,
                ),
              ),
            ),
            SizedBox(height: 2),
            Text(
              'Desempenho operacional da oficina',
              style: TextStyle(
                fontSize: 13,
                color: Color(
                  0xFF6B7A99,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
