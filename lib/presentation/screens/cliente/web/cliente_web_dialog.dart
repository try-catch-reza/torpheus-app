import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:torpheus/core/constants/custom_colors.dart';

// ── Tipo de pessoa ────────────────────────────────────────────────────────────

enum TipoPessoa { fisica, juridica }

// ── Entrada pública ───────────────────────────────────────────────────────────

/// Dialog de cadastro de cliente no padrão Torphéus.
///
/// Uso:
/// ```dart
/// CadastrarClienteDialog.show(
///   context,
///   onCadastrar: (dados) => bloc.add(ClienteCadastrar(dados)),
/// );
/// ```
abstract class CadastrarClienteDialog {
  static Future<void> show(
      BuildContext context, {
        required void Function(CadastrarClienteDados dados) onCadastrar,
      }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black45,
      builder: (_) => _CadastrarClienteDialogWidget(
        onCadastrar: onCadastrar,
      ),
    );
  }
}

// ── Model de saída ────────────────────────────────────────────────────────────

class CadastrarClienteDados {
  const CadastrarClienteDados({
    required this.tipoPessoa,
    required this.nome,
    required this.documento,
    required this.telefone,
    required this.email,
  });

  final TipoPessoa tipoPessoa;
  final String nome;

  /// CPF para Pessoa Física, CNPJ para Pessoa Jurídica
  final String documento;
  final String telefone;
  final String email;
}

// ── Widget principal ──────────────────────────────────────────────────────────

class _CadastrarClienteDialogWidget extends StatefulWidget {
  const _CadastrarClienteDialogWidget({required this.onCadastrar});

  final void Function(CadastrarClienteDados dados) onCadastrar;

  @override
  State<_CadastrarClienteDialogWidget> createState() =>
      _CadastrarClienteDialogWidgetState();
}

class _CadastrarClienteDialogWidgetState
    extends State<_CadastrarClienteDialogWidget> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _documentoController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _emailController = TextEditingController();

  TipoPessoa _tipoPessoa = TipoPessoa.fisica;

  @override
  void dispose() {
    _nomeController.dispose();
    _documentoController.dispose();
    _telefoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    widget.onCadastrar(
      CadastrarClienteDados(
        tipoPessoa: _tipoPessoa,
        nome: _nomeController.text.trim(),
        documento: _documentoController.text.trim(),
        telefone: _telefoneController.text.trim(),
        email: _emailController.text.trim(),
      ),
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Material(
            color: Colors.white,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Header ────────────────────────────────────────────
                  _DialogHeader(
                    onClose: () => Navigator.of(context).pop(),
                  ),

                  // ── Conteúdo ──────────────────────────────────────────
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Toggle Pessoa Física / Jurídica
                        _TipoPessoaToggle(
                          selected: _tipoPessoa,
                          onChanged: (tipo) {
                            setState(() {
                              _tipoPessoa = tipo;
                              _documentoController.clear();
                            });
                          },
                        ),

                        const SizedBox(height: 20),

                        // Nome completo / Razão social
                        _FieldLabel(
                          _tipoPessoa == TipoPessoa.fisica
                              ? 'Nome completo'
                              : 'Razão social',
                        ),
                        const SizedBox(height: 6),
                        _FormField(
                          controller: _nomeController,
                          hint: _tipoPessoa == TipoPessoa.fisica
                              ? 'João da Silva'
                              : 'Empresa Ltda.',
                          validator: (v) => v == null || v.trim().isEmpty
                              ? 'Campo obrigatório'
                              : null,
                        ),

                        const SizedBox(height: 16),

                        // CPF/CNPJ + Telefone (lado a lado)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _FieldLabel(
                                    _tipoPessoa == TipoPessoa.fisica
                                        ? 'CPF'
                                        : 'CNPJ',
                                  ),
                                  const SizedBox(height: 6),
                                  _FormField(
                                    controller: _documentoController,
                                    hint: _tipoPessoa == TipoPessoa.fisica
                                        ? '000.000.000-00'
                                        : '00.000.000/0001-00',
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      _tipoPessoa == TipoPessoa.fisica
                                          ? _CpfInputFormatter()
                                          : _CnpjInputFormatter(),
                                    ],
                                    validator: (v) {
                                      if (v == null || v.trim().isEmpty) {
                                        return 'Campo obrigatório';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(width: 12),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const _FieldLabel('Telefone'),
                                  const SizedBox(height: 6),
                                  _FormField(
                                    controller: _telefoneController,
                                    hint: '(49) 99999-9999',
                                    keyboardType: TextInputType.phone,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      _TelefoneInputFormatter(),
                                    ],
                                    validator: (v) => v == null || v.trim().isEmpty
                                        ? 'Campo obrigatório'
                                        : null,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // E-mail
                        const _FieldLabel('E-mail'),
                        const SizedBox(height: 6),
                        _FormField(
                          controller: _emailController,
                          hint: 'cliente@email.com',
                          keyboardType: TextInputType.emailAddress,
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) {
                              return 'Campo obrigatório';
                            }
                            if (!RegExp(r'^[\w.-]+@[\w.-]+\.\w{2,}$')
                                .hasMatch(v.trim())) {
                              return 'E-mail inválido';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),

                  // ── Footer: botões ────────────────────────────────────
                  _DialogFooter(
                    onCancelar: () => Navigator.of(context).pop(),
                    onCadastrar: _submit,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Header ────────────────────────────────────────────────────────────────────

class _DialogHeader extends StatelessWidget {
  const _DialogHeader({required this.onClose});

  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 16, 16),
      child: Row(
        children: [
          const Text(
            'Cadastrar Cliente',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1B2A4A),
              decoration: TextDecoration.none,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: onClose,
            icon: const Icon(Icons.close_rounded),
            color: const Color(0xFF9BAABB),
            iconSize: 20,
            splashRadius: 18,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          ),
        ],
      ),
    );
  }
}

// ── Toggle Pessoa Física / Jurídica ───────────────────────────────────────────

class _TipoPessoaToggle extends StatelessWidget {
  const _TipoPessoaToggle({
    required this.selected,
    required this.onChanged,
  });

  final TipoPessoa selected;
  final ValueChanged<TipoPessoa> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: const Color(0xFFF0F2F5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          _ToggleOption(
            label: 'Pessoa Física',
            isSelected: selected == TipoPessoa.fisica,
            onTap: () => onChanged(TipoPessoa.fisica),
            isFirst: true,
          ),
          _ToggleOption(
            label: 'Pessoa Jurídica',
            isSelected: selected == TipoPessoa.juridica,
            onTap: () => onChanged(TipoPessoa.juridica),
            isFirst: false,
          ),
        ],
      ),
    );
  }
}

class _ToggleOption extends StatelessWidget {
  const _ToggleOption({
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.isFirst,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isFirst;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 40,
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(7),
            border: isSelected
                ? Border.all(color: const Color(0xFFDDE1EA))
                : null,
            boxShadow: isSelected
                ? [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 4,
                offset: const Offset(0, 1),
              ),
            ]
                : null,
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected
                    ? const Color(0xFF1B2A4A)
                    : const Color(0xFF9BAABB),
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Label do campo ────────────────────────────────────────────────────────────

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: Color(0xFF6B7A99),
        letterSpacing: 0.2,
        decoration: TextDecoration.none,
      ),
    );
  }
}

// ── Campo de formulário ───────────────────────────────────────────────────────

class _FormField extends StatelessWidget {
  const _FormField({
    required this.controller,
    required this.hint,
    this.keyboardType,
    this.inputFormatters,
    this.validator,
  });

  final TextEditingController controller;
  final String hint;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      validator: validator,
      style: const TextStyle(
        fontSize: 13,
        color: Color(0xFF1B2A4A),
        decoration: TextDecoration.none,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          fontSize: 13,
          color: Color(0xFFB0B8CC),
          decoration: TextDecoration.none,
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFDDE1EA)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFDDE1EA)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF1B2A4A), width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFC0392B)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFC0392B), width: 1.5),
        ),
        errorStyle: const TextStyle(
          fontSize: 11,
          color: Color(0xFFC0392B),
          decoration: TextDecoration.none,
        ),
      ),
    );
  }
}

// ── Footer ────────────────────────────────────────────────────────────────────

class _DialogFooter extends StatelessWidget {
  const _DialogFooter({
    required this.onCancelar,
    required this.onCadastrar,
  });

  final VoidCallback onCancelar;
  final VoidCallback onCadastrar;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 20),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Color(0xFFF0F2F5))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Cancelar
          SizedBox(
            height: 38,
            child: OutlinedButton(
              onPressed: onCancelar,
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF6B7A99),
                side: const BorderSide(color: Color(0xFFDDE1EA)),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Cancelar',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ),

          const SizedBox(width: 10),

          // Cadastrar
          SizedBox(
            height: 38,
            child: ElevatedButton(
              onPressed: onCadastrar,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstants.chambray,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Cadastrar cliente',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Formatadores de input ─────────────────────────────────────────────────────

class _CpfInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    final digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    final buffer = StringBuffer();

    for (int i = 0; i < digits.length && i < 11; i++) {
      if (i == 3 || i == 6) buffer.write('.');
      if (i == 9) buffer.write('-');
      buffer.write(digits[i]);
    }

    final text = buffer.toString();
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}

class _CnpjInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    final digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    final buffer = StringBuffer();

    for (int i = 0; i < digits.length && i < 14; i++) {
      if (i == 2 || i == 5) buffer.write('.');
      if (i == 8) buffer.write('/');
      if (i == 12) buffer.write('-');
      buffer.write(digits[i]);
    }

    final text = buffer.toString();
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}

class _TelefoneInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    final digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    final buffer = StringBuffer();

    for (int i = 0; i < digits.length && i < 11; i++) {
      if (i == 0) buffer.write('(');
      if (i == 2) buffer.write(') ');
      if (i == 7) buffer.write('-');
      buffer.write(digits[i]);
    }

    final text = buffer.toString();
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}