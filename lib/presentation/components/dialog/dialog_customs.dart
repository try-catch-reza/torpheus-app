import 'package:flutter/material.dart';

// ── Tipos ─────────────────────────────────────────────────────────────────────

enum _StatusType { erro, atencao, sucesso, info }

// ── Entrada pública ───────────────────────────────────────────────────────────

/// Dialogs de status no padrão Torphéus.
///
/// Uso:
/// ```dart
/// StatusDialog.erro(context,
///   mensagem: 'Não foi possível salvar.',
///   onConfirmar: () {},
/// );
///
/// StatusDialog.atencao(context,
///   mensagem: 'Esta ação não poderá ser desfeita.',
///   onConfirmar: () {},
/// );
///
/// StatusDialog.sucesso(context,
///   mensagem: 'Operação realizada com sucesso.',
/// );
///
/// StatusDialog.info(context,
///   mensagem: 'Acesse Relatórios para ver o histórico.',
/// );
/// ```
abstract class StatusDialog {
  static Future<void> erro(
      BuildContext context, {
        required String mensagem,
        String labelConfirmar = 'Tentar novamente',
        VoidCallback? onFechar,
        VoidCallback? onConfirmar,
        bool barrierDismissible = true,
      }) =>
      _show(
        context,
        type: _StatusType.erro,
        mensagem: mensagem,
        labelConfirmar: labelConfirmar,
        onFechar: onFechar,
        onConfirmar: onConfirmar,
        barrierDismissible: barrierDismissible,
      );

  static Future<void> atencao(
      BuildContext context, {
        required String mensagem,
        String labelConfirmar = 'Confirmar',
        VoidCallback? onFechar,
        VoidCallback? onConfirmar,
        bool barrierDismissible = false,
      }) =>
      _show(
        context,
        type: _StatusType.atencao,
        mensagem: mensagem,
        labelConfirmar: labelConfirmar,
        onFechar: onFechar,
        onConfirmar: onConfirmar,
        barrierDismissible: barrierDismissible,
      );

  static Future<void> sucesso(
      BuildContext context, {
        required String mensagem,
        String labelConfirmar = 'Continuar',
        VoidCallback? onConfirmar,
        bool barrierDismissible = true,
      }) =>
      _show(
        context,
        type: _StatusType.sucesso,
        mensagem: mensagem,
        labelConfirmar: labelConfirmar,
        onConfirmar: onConfirmar,
        barrierDismissible: barrierDismissible,
      );

  static Future<void> info(
      BuildContext context, {
        required String mensagem,
        String labelConfirmar = 'Entendido',
        VoidCallback? onFechar,
        VoidCallback? onConfirmar,
        bool barrierDismissible = true,
      }) =>
      _show(
        context,
        type: _StatusType.info,
        mensagem: mensagem,
        labelConfirmar: labelConfirmar,
        onFechar: onFechar,
        onConfirmar: onConfirmar,
        barrierDismissible: barrierDismissible,
      );

  // ── Interno ─────────────────────────────────────────────────────────────────

  static Future<void> _show(
      BuildContext context, {
        required _StatusType type,
        required String mensagem,
        required String labelConfirmar,
        VoidCallback? onFechar,
        VoidCallback? onConfirmar,
        bool barrierDismissible = true,
      }) {
    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierColor: Colors.black54,
      builder: (_) => _StatusDialogWidget(
        type: type,
        mensagem: mensagem,
        labelConfirmar: labelConfirmar,
        onFechar: onFechar,
        onConfirmar: onConfirmar,
      ),
    );
  }
}

// ── Widget ────────────────────────────────────────────────────────────────────

class _StatusDialogWidget extends StatelessWidget {
  const _StatusDialogWidget({
    required this.type,
    required this.mensagem,
    required this.labelConfirmar,
    this.onFechar,
    this.onConfirmar,
  });

  final _StatusType type;
  final String mensagem;
  final String labelConfirmar;
  final VoidCallback? onFechar;
  final VoidCallback? onConfirmar;

  @override
  Widget build(BuildContext context) {
    final config = _StatusConfig.from(type);
    final hasCloseButton = type != _StatusType.sucesso;

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

                // Corpo: ícone + keyword + mensagem
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

                      const SizedBox(height: 10),

                      // Palavra-chave
                      Text(
                        config.keyword,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1B2A4A),
                          decoration: TextDecoration.none,
                        ),
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
                      // Botão fechar vermelho suave — ausente no sucesso
                      if (hasCloseButton) ...[
                        Expanded(
                          child: _DialogButton(
                            label: 'Fechar',
                            background: const Color(0xFFFEE2E2),
                            foreground: const Color(0xFFC0392B),
                            onTap: () {
                              Navigator.of(context).pop();
                              onFechar?.call();
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],

                      // Botão confirmar — segue a cor da barra
                      Expanded(
                        child: _DialogButton(
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

// ── Botão interno ─────────────────────────────────────────────────────────────

class _DialogButton extends StatelessWidget {
  const _DialogButton({
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
            letterSpacing: 0.8,
            color: foreground,
            decoration: TextDecoration.none,
          ),
        ),
      ),
    );
  }
}

// ── Configuração por tipo ─────────────────────────────────────────────────────

class _StatusConfig {
  const _StatusConfig({
    required this.barColor,
    required this.iconBg,
    required this.iconColor,
    required this.icon,
    required this.keyword,
  });

  final Color barColor;
  final Color iconBg;
  final Color iconColor;
  final IconData icon;
  final String keyword;

  factory _StatusConfig.from(_StatusType type) {
    return switch (type) {
      _StatusType.erro => const _StatusConfig(
        barColor: Color(0xFFC0392B),
        iconBg: Color(0xFFFEE2E2),
        iconColor: Color(0xFFC0392B),
        icon: Icons.cancel_rounded,
        keyword: 'Erro',
      ),
      _StatusType.atencao => const _StatusConfig(
        barColor: Color(0xFFD97706),
        iconBg: Color(0xFFFEF3C7),
        iconColor: Color(0xFFD97706),
        icon: Icons.warning_amber_rounded,
        keyword: 'Atenção',
      ),
      _StatusType.sucesso => const _StatusConfig(
        barColor: Color(0xFF16A34A),
        iconBg: Color(0xFFDCFCE7),
        iconColor: Color(0xFF16A34A),
        icon: Icons.check_circle_rounded,
        keyword: 'Sucesso',
      ),
      _StatusType.info => const _StatusConfig(
        barColor: Color(0xFF1B2A4A),
        iconBg: Color(0xFFE8ECF4),
        iconColor: Color(0xFF1B2A4A),
        icon: Icons.info_rounded,
        keyword: 'Informação',
      ),
    };
  }
}