import 'package:flutter/material.dart';

class StatusAtivo extends StatelessWidget {
  const StatusAtivo({
    super.key,
    required this.dot,
  });

  final bool dot;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: dot ? const Color(0xFFD1FAE5) : const Color(0xFFFEE2E2),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (dot) ...[
            Container(
              width: 6,
              height: 6,
              margin: const EdgeInsets.only(right: 4),
              decoration: BoxDecoration(
                color: dot ? const Color(0xFF065F46) : const Color(0xFF991B1B),
                shape: BoxShape.circle,
              ),
            ),
          ],
          Text(
            dot ? 'Ativo' : 'Inativo',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: dot ? const Color(0xFF065F46) : const Color(0xFF991B1B),
            ),
          ),
        ],
      ),
    );
  }
}
