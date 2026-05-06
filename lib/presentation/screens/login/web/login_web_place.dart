import 'package:flutter/material.dart';

class LoginWebPlace extends StatelessWidget {
  const LoginWebPlace({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.directions_car_rounded,
          color: const Color(0xFF8FA3C0).withOpacity(0.45),
          size: 52,
        ),
        const SizedBox(height: 10),
        const Text(
          'Imagem da empresa',
          style: TextStyle(
            fontSize: 12,
            color: Color(0xFF8FA3C0),
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }
}