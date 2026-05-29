import 'package:flutter/material.dart';
import 'package:torpheus/core/constants/extension/string_extension.dart';
import 'package:torpheus/data/models/mecanico_model.dart';

class MecanicoCard extends StatelessWidget {
  const MecanicoCard({super.key, required this.mecanico});

  final FuncionarioModel mecanico;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey.shade300,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8EEF9),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Text(
                  mecanico.nome?.iniciais ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3563E9),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      mecanico.nome ?? '',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    const SizedBox(height: 3),
                    const Text(
                      'Motor e Suspensão',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFE6F4EA),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  mecanico.isActive ?? false ? 'Ativo' : 'Inativo',
                  style: const TextStyle(
                    color: Color(0xFF2E7D32),
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Divider(height: 1, thickness: 1, color: Colors.grey.shade300),
          const SizedBox(height: 6),
          // Layout responsivo: em larguras pequenas, empilha os itens verticalmente para evitar overflow
          LayoutBuilder(
            builder: (context, constraints) {
              final isNarrow = constraints.maxWidth < 300;
              return isNarrow
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _infoItem(titulo: 'OS ativas', valor: '2'),
                        const SizedBox(height: 6),
                        _infoItem(titulo: 'Concluídas', valor: '47'),
                        const SizedBox(height: 6),
                        _infoItem(titulo: 'T. médio', valor: '3h 20min'),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: _infoItem(titulo: 'OS ativas', valor: '2')),
                        const SizedBox(width: 8),
                        Expanded(child: _infoItem(titulo: 'Concluídas', valor: '47')),
                        const SizedBox(width: 8),
                        Expanded(child: _infoItem(titulo: 'T. médio', valor: '3h 20min')),
                      ],
                    );
            },
          ),
        ],
      ),
    );
  }

  Widget _infoItem({
    required String titulo,
    required String valor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titulo,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          valor,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A237E),
          ),
        ),
      ],
    );
  }
}
