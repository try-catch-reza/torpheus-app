import 'package:flutter/material.dart';

class ListaVaziaCustom extends StatelessWidget {
  const ListaVaziaCustom({
    super.key,
    required this.message,
    required this.subMessage,
  });

  final String message;
  final String subMessage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.search,
            size: 48,
            color: Color(0xFFCDD3DE),
          ),
          const SizedBox(height: 12),
          Text(
            message,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF9BAABB),
              decoration: TextDecoration.none,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subMessage,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFFB0B8CC),
              decoration: TextDecoration.none,
            ),
          ),
        ],
      ),
    );
  }
}
