import 'package:flutter/material.dart';

class MecanicoVazio extends StatelessWidget {
  const MecanicoVazio({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFEAEDF2)),
      ),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.build_circle_outlined,
              size: 48,
              color: Color(0xFFCDD3DE),
            ),
            SizedBox(height: 12),
            Text(
              'Nenhum mecânico encontrado',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF9BAABB),
                decoration: TextDecoration.none,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Tente buscar por outro nome ou CREP.',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFFB0B8CC),
                decoration: TextDecoration.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
