import 'package:flutter/material.dart';

class RecuperarSenhaWebFooter extends StatelessWidget {
  const RecuperarSenhaWebFooter({super.key});

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(
      fontSize: 11,
      color: Color(0xFF8FA3C0),
      letterSpacing: 0.5,
      decoration: TextDecoration.none,
    );
    const dot = Text(
      ' • ',
      style: TextStyle(
        fontSize: 11,
        color: Color(0xFF4A5E7A),
        decoration: TextDecoration.none,
      ),
    );

    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('v1.0.0', style: style),
        dot,
        Text('UniSenai Chapecó', style: style),
        dot,
        Text('2026', style: style),
      ],
    );
  }
}
