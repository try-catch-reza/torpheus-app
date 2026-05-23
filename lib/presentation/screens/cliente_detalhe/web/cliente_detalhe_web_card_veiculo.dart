import 'package:flutter/material.dart';
import 'package:torpheus/core/constants/enum/status_veiculo.dart';
import 'package:torpheus/data/models/veiculo_cliente_model.dart';

class ClienteDetalheWebCardVeiculo extends StatelessWidget {
  const ClienteDetalheWebCardVeiculo({required this.veiculos, super.key});

  final List<VeiculoClienteModel>? veiculos;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFEAEDF2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header do card
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'Veículos atendidos',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1B2A4A),
                        decoration: TextDecoration.none,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 7,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8ECF4),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${veiculos?.length}',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1B2A4A),
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                const Text(
                  'Veículos que este cliente trouxe em OS',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF9BAABB),
                    decoration: TextDecoration.none,
                  ),
                ),
              ],
            ),
          ),

          const Divider(height: 1, color: Color(0xFFF0F2F5)),

          // Lista de veículos
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: veiculos?.length ?? 0,
            separatorBuilder: (_, __) {
              return const Divider(height: 1, color: Color(0xFFF0F2F5));
            },
            itemBuilder: (context, index) {
              return _VeiculoRow(veiculo: veiculos?[index]);
            },
          ),
        ],
      ),
    );
  }
}

class _VeiculoRow extends StatefulWidget {
  const _VeiculoRow({required this.veiculo});

  final VeiculoClienteModel? veiculo;

  @override
  State<_VeiculoRow> createState() => _VeiculoRowState();
}

class _VeiculoRowState extends State<_VeiculoRow> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final config = _StatusConfig.from(
      widget.veiculo?.status ?? StatusVeiculo.aguardando,
    );

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        color: _hovered ? const Color(0xFFF8F9FC) : Colors.transparent,
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
        child: Row(
          children: [
            // Ícone do carro
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFE8ECF4),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.directions_car_rounded,
                color: Color(0xFF9BAABB),
                size: 20,
              ),
            ),

            const SizedBox(width: 14),

            // Dados do veículo
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        widget.veiculo?.placa ?? '',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1B4FA8),
                          decoration: TextDecoration.none,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        widget.veiculo?.modelo ?? '',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF1B2A4A),
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    widget.veiculo?.descricao ?? '',
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF9BAABB),
                      decoration: TextDecoration.none,
                    ),
                  ),
                  const SizedBox(height: 6),
                  // Badge de status
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: config.bg,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: config.dot,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          widget.veiculo?.status.label ?? '',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: config.text,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Icon(
              Icons.chevron_right_rounded,
              size: 18,
              color: _hovered ? const Color(0xFF1B2A4A) : const Color(0xFFCDD3DE),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusConfig {
  const _StatusConfig({
    required this.bg,
    required this.dot,
    required this.text,
  });

  final Color bg;
  final Color dot;
  final Color text;

  factory _StatusConfig.from(StatusVeiculo status) {
    return switch (status) {
      StatusVeiculo.emAndamento => const _StatusConfig(
          bg: Color(0xFFEFF6FF),
          dot: Color(0xFF1B4FA8),
          text: Color(0xFF1B4FA8),
        ),
      StatusVeiculo.concluido => const _StatusConfig(
          bg: Color(0xFFF0FDF4),
          dot: Color(0xFF16A34A),
          text: Color(0xFF16A34A),
        ),
      StatusVeiculo.aguardando => const _StatusConfig(
          bg: Color(0xFFFFFBF0),
          dot: Color(0xFFD97706),
          text: Color(0xFFD97706),
        ),
      StatusVeiculo.cancelado => const _StatusConfig(
          bg: Color(0xFFFFF5F5),
          dot: Color(0xFFC0392B),
          text: Color(0xFFC0392B),
        ),
    };
  }
}
