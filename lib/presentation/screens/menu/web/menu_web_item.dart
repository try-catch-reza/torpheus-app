import 'package:flutter/material.dart';

import '../../../../data/models/menu_item.dart';

class MenuWebItem extends StatelessWidget {
  const MenuWebItem({
    super.key,
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  final MenuItem item;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 1),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF253A60) : Colors.transparent,
          border: isSelected
              ? const Border(
                  left: BorderSide(color: Colors.white, width: 3),
                )
              : null,
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(isSelected ? 13 : 16, 12, 16, 12),
          child: Row(
            children: [
              Icon(
                item.icon,
                size: 18,
                color: isSelected ? Colors.white : const Color(0xFF8FA3C0),
              ),
              const SizedBox(width: 14),
              Text(
                item.label,
                style: TextStyle(
                  fontSize: 13,
                  decoration: TextDecoration.none,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected ? Colors.white : const Color(0xFF8FA3C0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
