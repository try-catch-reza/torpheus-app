import 'package:flutter/material.dart';

class SearchCustom extends StatelessWidget {
  const SearchCustom({
    super.key,
    required this.controller,
    this.hintText = 'Buscar por nome',
    this.width = 340,
  });

  final TextEditingController controller;
  final String hintText;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, left: 20, right: 20),
      child: SizedBox(
        height: 40,
        width: width,
        child: TextField(
          controller: controller,
          style: const TextStyle(
            fontSize: 13,
            color: Color(0xFF1B2A4A),
            decoration: TextDecoration.none,
          ),
          decoration: InputDecoration(
            hintText: hintText,
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
      ),
    );
  }
}
