import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/data/models/permissao_model.dart';

import '../bloc/perfis_bloc.dart';
import '../bloc/perfis_event.dart';

class PerfisMobilePermissaoCard extends StatelessWidget {
  const PerfisMobilePermissaoCard({super.key, required this.permissao});

  final PermissaoModel permissao;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<PerfisBloc>().add(PerfisAdicionarPermissao(permissao));
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: permissao.isSelected ? const Color(0xFFF0FBF6) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: permissao.isSelected
                ? const Color(0xFF1D9E75)
                : const Color(0xFFDDDDD8),
            width: 0.5,
          ),
        ),
        child: Row(
          children: [
            _Checkbox(ativa: permissao.isSelected),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    permissao.titulo,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF1A1A18),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    permissao.acao,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF9A9A96),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Checkbox extends StatelessWidget {
  const _Checkbox({required this.ativa});

  final bool ativa;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      width: 18,
      height: 18,
      decoration: BoxDecoration(
        color: ativa ? const Color(0xFF1E3A5F) : Colors.transparent,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: ativa ? const Color(0xFF1E3A5F) : const Color(0xFFBBBBB7),
          width: 1.5,
        ),
      ),
      child:
          ativa ? const Icon(Icons.check, size: 12, color: Colors.white) : null,
    );
  }
}
