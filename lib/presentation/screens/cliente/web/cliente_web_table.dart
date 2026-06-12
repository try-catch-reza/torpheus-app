import 'package:flutter/material.dart';
import 'package:torpheus/core/constants/extension/string_extension.dart';

import '../../../../core/constants/color_constants.dart';
import '../../../../data/models/cliente_model.dart';

// ── Flex compartilhado entre header e rows ────────────────────────────────────
// Altere aqui e ambos se alinham automaticamente.
const _kFlex = (
  nome: 3,
  tipo: 2,
  documento: 3,
  telefone: 2,
  criado: 2,
  status: 2,
);

class ClienteWebTable extends StatelessWidget {
  const ClienteWebTable({
    super.key,
    required this.clientes,
    required this.onTap,
  });

  final List<ClienteModel> clientes;
  final ValueChanged<ClienteModel>? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFEEEEEA), width: 0.5),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          const _TableHeader(),
          const Divider(height: 1, thickness: 0.5, color: Color(0xFFEEEEEA)),
          Expanded(
            child: ListView.separated(
              itemCount: clientes.length,
              separatorBuilder: (_, __) => const Divider(
                height: 1,
                thickness: 0.5,
                color: Color(0xFFEEEEEA),
              ),
              itemBuilder: (context, i) {
                final cliente = clientes[i];
                return _TableRow(
                  cliente: cliente,
                  onTap: onTap != null ? () => onTap!(cliente) : null,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ── Header ────────────────────────────────────────────────────────────────────

class _TableHeader extends StatelessWidget {
  const _TableHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Row(
        children: [
          _HeaderCell('Nome', flex: _kFlex.nome),
          _HeaderCell('Tipo', flex: _kFlex.tipo),
          _HeaderCell('Documento', flex: _kFlex.documento),
          _HeaderCell('Telefone', flex: _kFlex.telefone),
          _HeaderCell('Criado', flex: _kFlex.criado),
          _HeaderCell('Status', flex: _kFlex.status),
          const SizedBox(width: 32), // reserva espaço do chevron
        ],
      ),
    );
  }
}

class _HeaderCell extends StatelessWidget {
  const _HeaderCell(this.label, {required this.flex});

  final String label;
  final int flex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Text(
        label.toUpperCase(),
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: Color(0xFF9A9A96),
          letterSpacing: 0.6,
        ),
      ),
    );
  }
}

// ── Row ───────────────────────────────────────────────────────────────────────

class _TableRow extends StatefulWidget {
  const _TableRow({required this.cliente, required this.onTap});

  final ClienteModel cliente;
  final VoidCallback? onTap;

  @override
  State<_TableRow> createState() => _TableRowState();
}

class _TableRowState extends State<_TableRow> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: widget.onTap != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          color: _hovered ? const Color(0xFFF7F7F5) : Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            children: [
              // Nome + avatar
              Expanded(
                flex: _kFlex.nome,
                child: Row(
                  children: [
                    _Avatar(nome: widget.cliente.nome ?? ''),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        widget.cliente.nome ?? '—',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF1A1A18),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              // Tipo (CPF / CNPJ)
              Expanded(
                flex: _kFlex.tipo,
                child: Text(
                  widget.cliente.documentoTipo?.label ?? '—',
                  style:
                      const TextStyle(fontSize: 13, color: Color(0xFF3A3A38)),
                ),
              ),
              // Documento (número formatado) — estava ausente antes
              Expanded(
                flex: _kFlex.documento,
                child: Text(
                  widget.cliente.documento ?? '—',
                  style:
                      const TextStyle(fontSize: 13, color: Color(0xFF3A3A38)),
                ),
              ),
              // Telefone
              Expanded(
                flex: _kFlex.telefone,
                child: Text(
                  widget.cliente.telefone ?? '—',
                  style:
                      const TextStyle(fontSize: 13, color: Color(0xFF3A3A38)),
                ),
              ),
              // Criado em
              Expanded(
                flex: _kFlex.criado,
                child: Text(
                  widget.cliente.createdAt.toString().formataData,
                  style:
                      const TextStyle(fontSize: 13, color: Color(0xFF3A3A38)),
                ),
              ),
              // Status
              Expanded(
                flex: _kFlex.status,
                child: _StatusBadge(ativo: widget.cliente.isActive ?? false),
              ),
              // Chevron — SizedBox fixo garante espaço mesmo quando oculto
              SizedBox(
                width: 32,
                child: widget.onTap != null
                    ? Icon(
                        Icons.chevron_right_rounded,
                        size: 20,
                        color: _hovered
                            ? ColorConstants.chambray
                            : const Color(0xFFBBBBB7),
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Status badge ──────────────────────────────────────────────────────────────

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.ativo});

  final bool ativo;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ativo ? const Color(0xFF1D9E75) : const Color(0xFFB4B2A9),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          ativo ? 'Ativo' : 'Inativo',
          style: TextStyle(
            fontSize: 13,
            color: ativo ? const Color(0xFF085041) : const Color(0xFF6B6B67),
          ),
        ),
      ],
    );
  }
}

// ── Avatar ────────────────────────────────────────────────────────────────────

class _Avatar extends StatelessWidget {
  const _Avatar({required this.nome});

  final String nome;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: const BoxDecoration(
        color: ColorConstants.mercury,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        _iniciais,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: ColorConstants.chambray,
        ),
      ),
    );
  }

  String get _iniciais {
    final partes = nome.trim().split(' ');
    if (partes.isEmpty || partes.first.isEmpty) return '?';
    if (partes.length == 1) return partes.first[0].toUpperCase();
    return (partes.first[0] + partes.last[0]).toUpperCase();
  }
}
