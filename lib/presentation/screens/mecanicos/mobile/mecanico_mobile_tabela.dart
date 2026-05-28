import 'package:flutter/material.dart';

import 'mecanico_mobile_table_row.dart';

class MecanicoMobileTabela extends StatelessWidget {
  const MecanicoMobileTabela({
    super.key,
    required this.mecanicos,
    required this.onMecanicoTap,
  });

  final List<dynamic> mecanicos;
  final ValueChanged<dynamic> onMecanicoTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFEAEDF2)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: mecanicos.length,
                  itemBuilder: (context, index) {
                    final mecanico = mecanicos[index];
                    final isLast = index == mecanicos.length - 1;
                    return MecanicoMobileTableRow(
                      mecanico: mecanico,
                      showDivider: !isLast,
                      onTap: () => onMecanicoTap(mecanico),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
