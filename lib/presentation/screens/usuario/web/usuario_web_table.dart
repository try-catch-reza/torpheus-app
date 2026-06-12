import 'package:flutter/material.dart';
import 'package:torpheus/core/constants/color_constants.dart';
import 'package:torpheus/data/models/usuario_model.dart';

class UsuarioWebTable extends StatelessWidget {
  const UsuarioWebTable({
    super.key,
    required this.usuarios,
  });

  final List<UsuarioModel> usuarios;

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
          _TableHeader(),
          const Divider(height: 1, thickness: 0.5, color: Color(0xFFEEEEEA)),
          Expanded(
            child: ListView.separated(
              itemCount: usuarios.length,
              separatorBuilder: (_, __) => const Divider(
                height: 1,
                thickness: 0.5,
                color: Color(0xFFEEEEEA),
              ),
              itemBuilder: (context, i) {
                return _TableRow(usuario: usuarios[i]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ── Cabeçalho ─────────────────────────────────────────────────────────────────

class _TableHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Row(
        children: [
          _HeaderCell('Usuário', flex: 4),
          _HeaderCell('E-mail', flex: 4),
          _HeaderCell('Criado em', flex: 3),
          _HeaderCell('Status', flex: 2),
          SizedBox(width: 32),
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

// ── Linha ─────────────────────────────────────────────────────────────────────

class _TableRow extends StatefulWidget {
  const _TableRow({required this.usuario});

  final UsuarioModel usuario;

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
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          color: _hovered ? const Color(0xFFF7F7F5) : Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: Row(
                  children: [
                    _Avatar(nome: widget.usuario.nome ?? ''),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        widget.usuario.nome ?? '—',
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
              // E-mail
              Expanded(
                flex: 4,
                child: Text(
                  widget.usuario.email ?? '—',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF3A3A38),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // Criado em
              Expanded(
                flex: 3,
                child: Text(
                  _formatarData(widget.usuario.createdAt),
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF3A3A38),
                  ),
                ),
              ),
              // Status
              Expanded(
                flex: 2,
                child: _StatusBadge(ativo: widget.usuario.isActive ?? false),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatarData(DateTime? data) {
    if (data == null) return '—';
    return '${data.day.toString().padLeft(2, '0')}/'
        '${data.month.toString().padLeft(2, '0')}/'
        '${data.year}';
  }
}

// ── Avatar com iniciais ───────────────────────────────────────────────────────

class _Avatar extends StatelessWidget {
  const _Avatar({required this.nome});

  final String nome;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: ColorConstants.chambray.withOpacity(0.12),
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

// ── Badge de status ───────────────────────────────────────────────────────────

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