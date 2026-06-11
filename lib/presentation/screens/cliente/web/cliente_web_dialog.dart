import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/screens/cliente/bloc/cliente_bloc.dart';

import '../../../../core/constants/color_constants.dart';
import '../../../../core/constants/extension/string_extension.dart';
import '../../../../data/models/cliente_model.dart';

class ClienteWeblDialog extends StatelessWidget {
  const ClienteWeblDialog({
    super.key,
    required this.cliente,
    required this.bloc,
  });

  final ClienteModel cliente;
  final ClienteBloc bloc;

  static Future<void> show(
    BuildContext context,
    ClienteModel cliente,
    ClienteBloc bloc,
  ) {
    return showDialog(
      context: context,
      builder: (_) => ClienteWeblDialog(
        cliente: cliente,
        bloc: bloc,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _DialogHeader(cliente: cliente),
                const SizedBox(height: 24),
                const _Divider(),
                const SizedBox(height: 20),
                const _SectionLabel('Contato'),
                const SizedBox(height: 12),
                _InfoGrid(children: [
                  _InfoTile(
                    icon: Icons.email_outlined,
                    label: 'E-mail',
                    value: cliente.email,
                  ),
                  _InfoTile(
                    icon: Icons.phone_outlined,
                    label: 'Telefone',
                    value: cliente.telefone,
                  ),
                ]),
                const SizedBox(height: 20),
                const _Divider(),
                const SizedBox(height: 20),
                const _SectionLabel('Documento'),
                const SizedBox(height: 12),
                _InfoGrid(children: [
                  _InfoTile(
                    icon: Icons.badge_outlined,
                    label: 'Tipo',
                    value: cliente.documentoTipo?.label,
                  ),
                  _InfoTile(
                    icon: Icons.numbers_outlined,
                    label: 'Número',
                    value: cliente.documento,
                  ),
                ]),
                if (_temEndereco) ...[
                  const SizedBox(height: 20),
                  const _Divider(),
                  const SizedBox(height: 20),
                  const _SectionLabel('Endereço'),
                  const SizedBox(height: 12),
                  _InfoGrid(children: [
                    _InfoTile(
                      icon: Icons.signpost_outlined,
                      label: 'Rua',
                      value: _ruaCompleta,
                    ),
                    _InfoTile(
                      icon: Icons.location_city_outlined,
                      label: 'Bairro',
                      value: cliente.endereco.bairro,
                    ),
                    _InfoTile(
                      icon: Icons.map_outlined,
                      label: 'Cidade / UF',
                      value: _cidadeUf,
                    ),
                    _InfoTile(
                      icon: Icons.markunread_mailbox_outlined,
                      label: 'CEP',
                      value: cliente.endereco.cep,
                    ),
                  ]),
                ],
                const SizedBox(height: 20),
                const _Divider(),
                const SizedBox(height: 20),
                _InfoGrid(children: [
                  _InfoTile(
                    icon: Icons.calendar_today_outlined,
                    label: 'Cadastrado em',
                    value: cliente.createdAt?.toString().formataData,
                  ),
                  _InfoTile(
                    icon: Icons.circle_outlined,
                    label: 'Status',
                    value: (cliente.isActive ?? false) ? 'Ativo' : 'Inativo',
                    valueColor: (cliente.isActive ?? false)
                        ? const Color(0xFF085041)
                        : const Color(0xFF6B6B67),
                  ),
                ]),
                const SizedBox(height: 28),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          bloc.add(ClienteAtualizar(cliente));
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: ColorConstants.chambray,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Editar',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: TextButton.styleFrom(
                          foregroundColor: ColorConstants.chambray,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Fechar',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool get _temEndereco {
    final e = cliente.endereco;
    return [e.rua, e.bairro, e.cidade, e.estado, e.cep]
        .any((v) => v != null && v.isNotEmpty);
  }

  String? get _ruaCompleta {
    final partes = [
      cliente.endereco.rua,
      cliente.endereco.numero,
      if (cliente.endereco.complemento?.isNotEmpty ?? false)
        cliente.endereco.complemento,
    ].whereType<String>().toList();
    return partes.isNotEmpty ? partes.join(', ') : null;
  }

  String? get _cidadeUf {
    final partes = [
      cliente.endereco.cidade,
      cliente.endereco.estado,
    ].whereType<String>().where((s) => s.isNotEmpty).toList();
    return partes.isNotEmpty ? partes.join(' / ') : null;
  }
}

// ── Header ────────────────────────────────────────────────────────────────────

class _DialogHeader extends StatelessWidget {
  const _DialogHeader({required this.cliente});

  final ClienteModel cliente;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _LargeAvatar(nome: cliente.nome ?? ''),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cliente.nome ?? '—',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1A1A18),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                '${cliente.documentoTipo?.label ?? ''}: ${cliente.documento ?? '—'}',
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF9A9A96),
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.close_rounded),
          color: const Color(0xFF9A9A96),
          tooltip: 'Fechar',
        ),
      ],
    );
  }
}

// ── Componentes internos ──────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label.toUpperCase(),
      style: const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w700,
        color: Color(0xFF9A9A96),
        letterSpacing: 0.8,
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) =>
      const Divider(height: 1, thickness: 0.5, color: Color(0xFFEEEEEA));
}

class _InfoGrid extends StatelessWidget {
  const _InfoGrid({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 12,
      children: children.map((c) => SizedBox(width: 230, child: c)).toList(),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
  });

  final IconData icon;
  final String label;
  final String? value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: const Color(0xFFBBBBB7)),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 11,
                  color: Color(0xFF9A9A96),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value ?? '—',
                style: TextStyle(
                  fontSize: 13,
                  color: valueColor ?? const Color(0xFF1A1A18),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _LargeAvatar extends StatelessWidget {
  const _LargeAvatar({required this.nome});

  final String nome;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: const BoxDecoration(
        color: ColorConstants.mercury,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        _iniciais,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
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
