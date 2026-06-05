import 'package:flutter/material.dart';
import 'package:torpheus/data/models/veiculo_model.dart';

/// Card com informações do veículo
class VeiculoDetalheWebCardInfo extends StatelessWidget {
  const VeiculoDetalheWebCardInfo({required this.veiculo, super.key});

  final VeiculoModel? veiculo;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFEAEDF2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ícone + modelo + placa
          Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8ECF4),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Icon(
                    Icons.directions_car_rounded,
                    color: Color(0xFF1B2A4A),
                    size: 28,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    veiculo?.modelo ?? '',
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1B2A4A),
                      decoration: TextDecoration.none,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    veiculo?.placa ?? '',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF6B7A99),
                      decoration: TextDecoration.none,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Divider(height: 1, color: Color(0xFFF0F2F5)),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _InfoField(
                  label: 'Tipo',
                  value: veiculo?.tipo?.label ?? '',
                ),
              ),
              Expanded(
                child: _InfoField(
                  label: 'Marca',
                  value: veiculo?.marca?.label ?? '',
                ),
              ),
              Expanded(
                child: _InfoField(
                  label: 'Ano',
                  value: veiculo?.ano.toString() ?? '',
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _InfoField(
                  label: 'Motor',
                  value: veiculo?.motor ?? '',
                ),
              ),
              Expanded(
                child: _InfoField(
                  label: 'Câmbio',
                  value: veiculo?.cambio?.label ?? '',
                ),
              ),
              Expanded(
                child: _InfoField(
                  label: 'Combustível',
                  value: veiculo?.combustivel?.label ?? '',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoField extends StatelessWidget {
  const _InfoField({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Color(0xFF9BAABB),
            letterSpacing: 0.4,
            decoration: TextDecoration.none,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF1B2A4A),
            decoration: TextDecoration.none,
          ),
        ),
      ],
    );
  }
}

