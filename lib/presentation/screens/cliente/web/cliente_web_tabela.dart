import 'package:flutter/material.dart';

import '../../../../data/models/cliente_model.dart';

class ClienteWebTabela extends StatelessWidget {
  const ClienteWebTabela({
    super.key,
    required this.clientes,
    required this.onClienteTap,
  });

  final List<ClienteModel> clientes;
  final ValueChanged<ClienteModel> onClienteTap;

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
              const _TableHeader(),
              Expanded(
                child: ListView.builder(
                  itemCount: clientes.length,
                  itemBuilder: (context, index) {
                    final cliente = clientes[index];
                    final isLast = index == clientes.length - 1;
                    return _ClienteRow(
                      cliente: cliente,
                      showDivider: !isLast,
                      onTap: () => onClienteTap(cliente),
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

class _TableHeader extends StatelessWidget {
  const _TableHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFFEAEDF2)),
        ),
      ),
      child: const Row(
        children: [
          Expanded(
            flex: 4,
            child: _HeaderCell('CLIENTE'),
          ),
          Expanded(
            flex: 3,
            child: _HeaderCell('CPF'),
          ),
          Expanded(
            flex: 3,
            child: _HeaderCell('TELEFONE'),
          ),
          Expanded(
            flex: 4,
            child: _HeaderCell('E-MAIL'),
          ),
          Expanded(
            flex: 2,
            child: _HeaderCell('VEÍCULOS'),
          ),
          SizedBox(width: 32),
        ],
      ),
    );
  }
}

class _HeaderCell extends StatelessWidget {
  const _HeaderCell(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: Color(0xFF9BAABB),
        letterSpacing: 0.6,
        decoration: TextDecoration.none,
      ),
    );
  }
}

class _ClienteRow extends StatefulWidget {
  const _ClienteRow({
    required this.cliente,
    required this.showDivider,
    required this.onTap,
  });

  final ClienteModel cliente;
  final bool showDivider;
  final VoidCallback onTap;

  @override
  State<_ClienteRow> createState() => _ClienteRowState();
}

class _ClienteRowState extends State<_ClienteRow> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MouseRegion(
          onEnter: (_) => setState(() => _hovered = true),
          onExit: (_) => setState(() => _hovered = false),
          child: GestureDetector(
            onTap: widget.onTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              color: _hovered ? const Color(0xFFF8F9FC) : Colors.transparent,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Row(
                      children: [
                        _Avatar(iniciais: widget.cliente.iniciais),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            widget.cliente.nome,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1B2A4A),
                              decoration: TextDecoration.none,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: _RowCell(widget.cliente.cpf),
                  ),
                  Expanded(
                    flex: 3,
                    child: _RowCell(widget.cliente.telefone),
                  ),
                  Expanded(
                    flex: 4,
                    child: _RowCell(widget.cliente.email),
                  ),
                  Expanded(
                    flex: 2,
                    child: _VeiculosBadge(
                      total: widget.cliente.totalVeiculos,
                    ),
                  ),
                  SizedBox(
                    width: 32,
                    child: Icon(
                      Icons.chevron_right_rounded,
                      size: 18,
                      color: _hovered
                          ? const Color(0xFF1B2A4A)
                          : const Color(0xFFCDD3DE),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (widget.showDivider)
          const Divider(height: 1, color: Color(0xFFF0F2F5)),
      ],
    );
  }
}

// ── Avatar ────────────────────────────────────────────────────────────────────

class _Avatar extends StatelessWidget {
  const _Avatar({required this.iniciais});

  final String iniciais;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: const Color(0xFFE8ECF4),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          iniciais,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1B2A4A),
            decoration: TextDecoration.none,
          ),
        ),
      ),
    );
  }
}

// ── Célula de texto ───────────────────────────────────────────────────────────

class _RowCell extends StatelessWidget {
  const _RowCell(this.value);

  final String value;

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: const TextStyle(
        fontSize: 13,
        color: Color(0xFF6B7A99),
        decoration: TextDecoration.none,
      ),
      overflow: TextOverflow.ellipsis,
    );
  }
}

// ── Badge de veículos ─────────────────────────────────────────────────────────

class _VeiculosBadge extends StatelessWidget {
  const _VeiculosBadge({required this.total});

  final int total;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFE8ECF4),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        '$total veículos',
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: Color(0xFF1B2A4A),
          decoration: TextDecoration.none,
        ),
      ),
    );
  }
}
