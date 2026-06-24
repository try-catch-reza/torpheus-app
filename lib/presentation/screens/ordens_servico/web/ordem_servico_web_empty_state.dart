import 'package:flutter/material.dart';

/// Exibido quando a OS não possui nenhum serviço atribuído.
class OrdemServicoWebEmptyState extends StatelessWidget {
  const OrdemServicoWebEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 180,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.manage_search_rounded,
              size: 48,
              color: Color(0xFFCDD3DE),
            ),
            SizedBox(height: 12),
            Text(
              'Nenhum serviço atribuído a essa OS',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF9BAABB),
                decoration: TextDecoration.none,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 4),
            Text(
              'Adicione um serviço para começar',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFFB0B8CC),
                decoration: TextDecoration.none,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}