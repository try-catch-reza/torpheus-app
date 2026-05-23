import 'package:flutter/material.dart';

class LoadingState extends StatelessWidget {
  const LoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFEAEDF2)),
      ),
      child: const Center(
        child: CircularProgressIndicator(
          color: Color(0xFF1B2A4A),
          strokeWidth: 2,
        ),
      ),
    );
  }
}