import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:torpheus/core/constants/custom_colors.dart';

enum TipoPessoa { fisica, juridica }

class CadastrarClienteBody extends StatefulWidget {
  const CadastrarClienteBody({
    super.key,
    required this.onCadastrar,
  });

  final void Function(CadastrarClienteDados dados) onCadastrar;

  @override
  State<CadastrarClienteBody> createState() => _CadastrarClienteBodyState();
}

class _CadastrarClienteBodyState extends State<CadastrarClienteBody> {
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
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Toggle Pessoa Física / Jurídica
                  _TipoPessoaToggle(
                    selected: _tipoPessoa,
                    onChanged: (tipo) => setState(() {
                      _tipoPessoa = tipo;
                      _documentoController.clear();
                    }),
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

                  // CPF / CNPJ
                  _FieldLabel(
                    _tipoPessoa == TipoPessoa.fisica ? 'CPF' : 'CNPJ',
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
                    validator: (v) => v == null || v.trim().isEmpty
                        ? 'Campo obrigatório'
                        : null,
                  ),

                  const SizedBox(height: 16),

                  // Telefone
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
          ),

          // ── Botões fixos no rodapé ───────────────────────────────────
          _Footer(
            onCancelar: () => Navigator.of(context).pop(),
            onCadastrar: _submit,
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
      height: 44,
      decoration: BoxDecoration(
        color: const Color(0xFFE8ECF4),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          _ToggleOption(
            label: 'Pessoa Física',
            isSelected: selected == TipoPessoa.fisica,
            onTap: () => onChanged(TipoPessoa.fisica),
          ),
          _ToggleOption(
            label: 'Pessoa Jurídica',
            isSelected: selected == TipoPessoa.juridica,
            onTap: () => onChanged(TipoPessoa.juridica),
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
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 44,
          margin: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.07),
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
        fontSize: 14,
        color: Color(0xFF1B2A4A),
        decoration: TextDecoration.none,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          fontSize: 14,
          color: Color(0xFFB0B8CC),
          decoration: TextDecoration.none,
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFDDE1EA)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFDDE1EA)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFF1B2A4A), width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFC0392B)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
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

// ── Rodapé com botões ─────────────────────────────────────────────────────────

class _Footer extends StatelessWidget {
  const _Footer({
    required this.onCancelar,
    required this.onCadastrar,
  });

  final VoidCallback onCancelar;
  final VoidCallback onCadastrar;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        20,
        12,
        20,
        12 + MediaQuery.of(context).padding.bottom,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFF0F2F5))),
      ),
      child: Row(
        children: [
          // Cancelar
          Expanded(
            child: SizedBox(
              height: 48,
              child: OutlinedButton(
                onPressed: onCancelar,
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF6B7A99),
                  side: const BorderSide(color: Color(0xFFDDE1EA)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Cancelar',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(width: 12),

          // Cadastrar
          Expanded(
            flex: 2,
            child: SizedBox(
              height: 48,
              child: ElevatedButton(
                onPressed: onCadastrar,
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstants.chambray,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Cadastrar cliente',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Formatadores ──────────────────────────────────────────────────────────────

class _CpfInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue old, TextEditingValue next) {
    final d = next.text.replaceAll(RegExp(r'\D'), '');
    final buf = StringBuffer();
    for (int i = 0; i < d.length && i < 11; i++) {
      if (i == 3 || i == 6) buf.write('.');
      if (i == 9) buf.write('-');
      buf.write(d[i]);
    }
    final t = buf.toString();
    return TextEditingValue(
        text: t, selection: TextSelection.collapsed(offset: t.length));
  }
}

class _CnpjInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue old, TextEditingValue next) {
    final d = next.text.replaceAll(RegExp(r'\D'), '');
    final buf = StringBuffer();
    for (int i = 0; i < d.length && i < 14; i++) {
      if (i == 2 || i == 5) buf.write('.');
      if (i == 8) buf.write('/');
      if (i == 12) buf.write('-');
      buf.write(d[i]);
    }
    final t = buf.toString();
    return TextEditingValue(
        text: t, selection: TextSelection.collapsed(offset: t.length));
  }
}

class _TelefoneInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue old, TextEditingValue next) {
    final d = next.text.replaceAll(RegExp(r'\D'), '');
    final buf = StringBuffer();
    for (int i = 0; i < d.length && i < 11; i++) {
      if (i == 0) buf.write('(');
      if (i == 2) buf.write(') ');
      if (i == 7) buf.write('-');
      buf.write(d[i]);
    }
    final t = buf.toString();
    return TextEditingValue(
        text: t, selection: TextSelection.collapsed(offset: t.length));
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
  final String documento;
  final String telefone;
  final String email;
}
