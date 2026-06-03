import 'package:flutter/material.dart';
import 'package:torpheus/core/constants/extension/string_extension.dart';
import 'package:torpheus/data/models/mecanico_model.dart';

/// Card com informações do funcionário
class FuncionarioDetalheWebCardInfo extends StatelessWidget {
  const FuncionarioDetalheWebCardInfo({required this.funcionario, super.key});

  final FuncionarioModel? funcionario;

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
          // Avatar + nome + status
          Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8ECF4),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    funcionario?.nome?.iniciais ?? '',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1B2A4A),
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    funcionario?.nome ?? '',
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1B2A4A),
                      decoration: TextDecoration.none,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    funcionario?.isActive == true ? 'Ativo' : 'Inativo',
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
                  label: 'Documento',
                  value: funcionario?.documento ?? '',
                ),
              ),
              Expanded(
                child: _InfoField(
                  label: 'Telefone',
                  value: funcionario?.telefone ?? '',
                ),
              ),
              Expanded(
                child: _InfoField(
                  label: 'Função',
                  value: funcionario?.funcao ?? '',
                ),
              ),
              Expanded(
                child: _InfoField(
                  label: 'Data de contratação',
                  value: funcionario?.hiredAt?.toString().formataData ?? '',
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

