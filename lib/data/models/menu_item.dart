import 'package:flutter/material.dart';

class MenuItem {
  const MenuItem({
    required this.icon,
    required this.label,
    this.permissaoNecessaria,
  });

  final IconData icon;
  final String label;
  final String? permissaoNecessaria;
}
