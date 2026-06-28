import 'package:flutter/material.dart';
import 'package:torpheus/core/constants/extension/string_extension.dart';
import 'package:torpheus/data/models/ordem_servico_model.dart';

class PainelMobileCard extends StatelessWidget {
  const PainelMobileCard({super.key, required this.ordemServico});

  final OrdemServicoModel ordemServico;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE8ECF0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: ordemServico.statusOrdem?.colorStatus,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircleAvatar(
                        radius: 3, backgroundColor: Colors.white),
                    const SizedBox(width: 6),
                    Text(
                      ordemServico.statusOrdem?.label ?? '',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: ordemServico.veiculoPlaca ?? '',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1B2A4A),
                  ),
                ),
                const TextSpan(
                  text: ' - ',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1B2A4A),
                  ),
                ),
                TextSpan(
                  text: ordemServico.veiculoModelo ?? '',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF6B7A99),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Divider(height: 1, color: Color(0xFFF2F4F7)),
          const SizedBox(height: 10),
          Row(
            children: [
              Text(
                ordemServico.clienteNome ?? '',
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF6B7A99),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 6),
                child: Text(
                  '·',
                  style: TextStyle(
                    color: Color(0xFF6B7A99),
                  ),
                ),
              ),
              Text(
                ordemServico.dataCriacao.toString().formataData,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF6B7A99),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
