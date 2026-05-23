import 'package:flutter/material.dart';

class ClienteWebSearch extends StatelessWidget {
  const ClienteWebSearch({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 340,
      height: 40,
      child: TextField(
        controller: controller,
        style: const TextStyle(
          fontSize: 13,
          color: Color(0xFF1B2A4A),
          decoration: TextDecoration.none,
        ),
        decoration: InputDecoration(
          hintText: 'Buscar por nome, CPF ou telefone...',
          hintStyle: const TextStyle(
            fontSize: 13,
            color: Color(0xFFB0B8CC),
            decoration: TextDecoration.none,
          ),
          prefixIcon: const Icon(
            Icons.search_rounded,
            size: 18,
            color: Color(0xFFB0B8CC),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFFDDE1EA)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFFDDE1EA)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFF1B2A4A), width: 1.5),
          ),
        ),
      ),
    );
  }
}
