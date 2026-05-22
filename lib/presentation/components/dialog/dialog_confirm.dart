import 'package:flutter/material.dart';

// ── Tipos ─────────────────────────────────────────────────────────────────────

enum ConfirmDialogType { neutro, exclusao, critico }

// ── Entrada pública ───────────────────────────────────────────────────────────

/// Dialog de confirmação com título, mensagem e dois botões.
///
/// Uso:
/// ```dart
/// // Padrão
/// ConfirmDialog.show(
///   context,
///   titulo: 'Salvar alterações?',
///   mensagem: 'As alterações serão salvas permanentemente.',
///   onConfirmar: () => bloc.add(Salvar()),
/// );
///
/// // Exclusão
/// ConfirmDialog.show(
///   context,
///   type: ConfirmDialogType.exclusao,
///   titulo: 'Excluir cliente?',
///   mensagem: 'Esta ação não poderá ser desfeita.',
///   labelConfirmar: 'Excluir',
///   onConfirmar: () => bloc.add(ClienteExcluir(id)),
/// );
///
/// // Crítico
/// ConfirmDialog.show(
///   context,
///   type: ConfirmDialogType.critico,
///   titulo: 'Fechar ordem de serviço?',
///   mensagem: 'A OS não poderá ser reaberta após ser fechada.',
///   labelConfirmar: 'Fechar OS',
///   onConfirmar: () => bloc.add(OsFechar(id)),
/// );
/// ```
abstract class ConfirmDialog {
  static Future<void> show(
      BuildContext context, {
        required String titulo,
        required String mensagem,
        ConfirmDialogType type = ConfirmDialogType.neutro,
        String labelCancelar = 'Cancelar',
        String labelConfirmar = 'Confirmar',
        VoidCallback? onCancelar,
        VoidCallback? onConfirmar,
        bool barrierDismissible = false,
      }) {
    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierColor: Colors.black54,
      builder: (_) => _ConfirmDialogWidget(
        type: type,
        titulo: titulo,
        mensagem: mensagem,
        labelCancelar: labelCancelar,
        labelConfirmar: labelConfirmar,
        onCancelar: onCancelar,
        onConfirmar: onConfirmar,
      ),
    );
  }
}

// ── Widget ────────────────────────────────────────────────────────────────────

class _ConfirmDialogWidget extends StatelessWidget {
  const _ConfirmDialogWidget({
    required this.type,
    required this.titulo,
    required this.mensagem,
    required this.labelCancelar,
    required this.labelConfirmar,
    this.onCancelar,
    this.onConfirmar,
  });

  final ConfirmDialogType type;
  final String titulo;
  final String mensagem;
  final String labelCancelar;
  final String labelConfirmar;
  final VoidCallback? onCancelar;
  final VoidCallback? onConfirmar;

  @override
  Widget build(BuildContext context) {
    final config = _ConfirmConfig.from(type);

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 360),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Material(
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Barra colorida no topo
                Container(height: 4, color: config.barColor),

                // Corpo: ícone + título + mensagem
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
                  child: Column(
                    children: [
                      // Ícone
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: config.iconBg,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          config.icon,
                          color: config.iconColor,
                          size: 24,
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Título
                      Text(
                        titulo,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1B2A4A),
                          decoration: TextDecoration.none,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 8),

                      // Mensagem
                      Text(
                        mensagem,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF6B7A99),
                          height: 1.6,
                          decoration: TextDecoration.none,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                // Botões
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      // Cancelar — sempre vermelho suave
                      Expanded(
                        child: _ConfirmButton(
                          label: labelCancelar,
                          background: const Color(0xFFFEE2E2),
                          foreground: const Color(0xFFC0392B),
                          onTap: () {
                            Navigator.of(context).pop();
                            onCancelar?.call();
                          },
                        ),
                      ),

                      const SizedBox(width: 8),

                      // Confirmar — segue a cor da barra
                      Expanded(
                        child: _ConfirmButton(
                          label: labelConfirmar,
                          background: config.barColor,
                          foreground: Colors.white,
                          onTap: () {
                            Navigator.of(context).pop();
                            onConfirmar?.call();
                          },
                        ),
                      ),
                    ],
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

// ── Botão ─────────────────────────────────────────────────────────────────────

class _ConfirmButton extends StatelessWidget {
  const _ConfirmButton({
    required this.label,
    required this.background,
    required this.foreground,
    required this.onTap,
  });

  final String label;
  final Color background;
  final Color foreground;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: background,
          foregroundColor: foreground,
          elevation: 0,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
            color: foreground,
            decoration: TextDecoration.none,
          ),
        ),
      ),
    );
  }
}

// ── Configuração por tipo ─────────────────────────────────────────────────────

class _ConfirmConfig {
  const _ConfirmConfig({
    required this.barColor,
    required this.iconBg,
    required this.iconColor,
    required this.icon,
  });

  final Color barColor;
  final Color iconBg;
  final Color iconColor;
  final IconData icon;

  factory _ConfirmConfig.from(ConfirmDialogType type) {
    return switch (type) {
      ConfirmDialogType.neutro => const _ConfirmConfig(
        barColor: Color(0xFF1B2A4A),
        iconBg: Color(0xFFE8ECF4),
        iconColor: Color(0xFF1B2A4A),
        icon: Icons.check_circle_outline_rounded,
      ),
      ConfirmDialogType.exclusao => const _ConfirmConfig(
        barColor: Color(0xFFC0392B),
        iconBg: Color(0xFFFEE2E2),
        iconColor: Color(0xFFC0392B),
        icon: Icons.delete_outline_rounded,
      ),
      ConfirmDialogType.critico => const _ConfirmConfig(
        barColor: Color(0xFFD97706),
        iconBg: Color(0xFFFEF3C7),
        iconColor: Color(0xFFD97706),
        icon: Icons.warning_amber_rounded,
      ),
    };
  }
}