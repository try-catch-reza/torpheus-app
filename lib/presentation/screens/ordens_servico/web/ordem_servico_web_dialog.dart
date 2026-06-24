import 'package:flutter/material.dart';
import 'package:torpheus/data/models/ordem_servico_model.dart';
import 'package:torpheus/data/models/servico_model.dart';
import 'ordem_servico_web_header.dart';
import 'ordem_servico_web_item.dart';
import 'ordem_servico_web_empty_state.dart';
import 'ordem_servico_web_toolbar.dart';

class OrdemServicoWebDialog extends StatelessWidget {
  const OrdemServicoWebDialog({
    super.key,
    required this.ordem,
    required this.onAdicionar,
    required this.onRemover,
  });

  final OrdemServicoModel ordem;
  final VoidCallback onAdicionar;
  final ValueChanged<ServicoModel> onRemover;

  @override
  Widget build(BuildContext context) {
    final servicos = ordem.servicos ?? [];

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 700, maxHeight: 700),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Material(
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ── Header azul ──────────────────────────────────────────
                OrdemServicoWebHeader(
                  ordem: ordem,
                  onFechar: () => Navigator.of(context).pop(),
                ),

                // ── Corpo scrollável ─────────────────────────────────────
                Flexible(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Toolbar: serviços (N) + botão adicionar
                        OrdemServicoWebServicosToolbar(
                          totalServicos: servicos.length,
                          // Do not pop the outer dialog here; simply call the
                          // provided onAdicionar callback. The caller already
                          // controls how the inner dialog should be opened and
                          // will pass the correct dialog context so the outer
                          // dialog remains open.
                          onAdicionar: onAdicionar,
                        ),

                        const SizedBox(height: 14),

                        // Lista ou empty state
                        if (servicos.isEmpty)
                          const OrdemServicoWebEmptyState()
                        else
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: servicos.length,
                            separatorBuilder: (_, __) =>
                            const SizedBox(height: 8),
                            itemBuilder: (context, index) {
                              final servico = servicos[index];
                              return OrdemServicoWebServicoItem(
                                servico: servico,
                                onRemover: () => onRemover(servico),
                              );
                            },
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}