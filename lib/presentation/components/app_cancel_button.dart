import 'package:flutter/material.dart';

class AppCancelButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;

  const AppCancelButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: icon != null
          ? Icon(icon, size: 18)
          : const SizedBox(),
      label: Text(text),
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.grey.shade100,
        foregroundColor: Colors.red.shade700,
        side: BorderSide(
          color: Colors.red.shade400,
          width: 1.5,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}