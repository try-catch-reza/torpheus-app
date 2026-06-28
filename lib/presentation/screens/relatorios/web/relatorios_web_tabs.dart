import 'package:flutter/material.dart';
import 'package:torpheus/core/constants/string_constants.dart';

class RelatoriosWebTabs extends StatelessWidget {
  const RelatoriosWebTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Semana / Mês / Trimestre
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: const Color(0xFFEEF0F3),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: List.generate(StringConstants.periodos.length, (i) {
              final selected = i == 1;
              return GestureDetector(
                onTap: () => {
                  /// Atualiza o periodo
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                  decoration: BoxDecoration(
                    color: selected ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: selected
                        ? [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 4,
                            )
                          ]
                        : [],
                  ),
                  child: Text(
                    StringConstants.periodos[i],
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                      color: selected
                          ? const Color(0xFF1B2A4A)
                          : const Color(0xFF6B7A99),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
        const Spacer(),
        // Visão geral / Produtividade / Serviços / Não realizados
        Row(
          children: List.generate(
            StringConstants.tabs.length,
            (i) {
              final selected = i == 1;
              return GestureDetector(
                onTap: () {
                  /// Atualiza a aba
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 4),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: selected
                            ? const Color(0xFF1B2A4A)
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                  ),
                  child: Text(
                    StringConstants.tabs[i],
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                      color: selected
                          ? const Color(0xFF1B2A4A)
                          : const Color(0xFF6B7A99),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
