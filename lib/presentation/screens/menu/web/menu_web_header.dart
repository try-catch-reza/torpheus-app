import 'package:flutter/material.dart';
import 'package:torpheus/core/constants/assets_contants.dart';

class MenuWebHeader extends StatelessWidget {
  const MenuWebHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
      child: Row(
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: const Color(0xFF253A60),
              borderRadius: BorderRadius.circular(9),
              border: Border.all(color: const Color(0xFF304D7A)),
            ),
            child: Image.asset(AssetsConstants.logoMarca),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'TORPHEUS',
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: 1.5,
                  ),
                ),
                Text(
                  'Nome oficina',
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: 11,
                    color: Color(0xFF8FA3C0),
                    fontWeight: FontWeight.w400,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}