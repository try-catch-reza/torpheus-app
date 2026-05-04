import 'package:flutter/material.dart';

class MenuWebHeader extends StatelessWidget {
  const MenuWebHeader({super.key, required this.nomeEmpresa});

  final String nomeEmpresa;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: const Color(0xFF253A60),
              borderRadius: BorderRadius.circular(9),
              border: Border.all(color: const Color(0xFF304D7A)),
            ),
            child: const Icon(
              Icons.build_rounded,
              color: Colors.white,
              size: 18,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'TORPHÉUS',
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: 1.5,
                  ),
                ),
                Text(
                  nomeEmpresa,
                  style: const TextStyle(
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