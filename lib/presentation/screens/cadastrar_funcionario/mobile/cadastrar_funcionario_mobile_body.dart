import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:torpheus/presentation/components/formatadores.dart';
import 'package:torpheus/presentation/screens/cadastrar_funcionario/web/cadastrar_funcionario_web_campo.dart';

import '../../../../core/constants/enum/funcao.dart';
import '../bloc/cadastrar_funcionario_bloc.dart';
import '../web/cadastrar_funcionario_web_dropdown.dart';

class CadastrarFuncionarioMobileBody extends StatefulWidget {
  const CadastrarFuncionarioMobileBody({
    super.key,
    required this.formKey,
    required this.nomeController,
    required this.documentoController,
    required this.telefoneController,
    required this.state,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController nomeController;
  final TextEditingController documentoController;
  final TextEditingController telefoneController;

  final CadastrarFuncionarioState state;

  @override
  State<CadastrarFuncionarioMobileBody> createState() =>
      _CadastrarFuncionarioMobileBodyState();
}

class _CadastrarFuncionarioMobileBodyState
    extends State<CadastrarFuncionarioMobileBody> {
  Funcao _selectedFuncao = Funcao.mecanico;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Form(
        key: widget.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CadastrarFuncionarioWebCampo(
                        label: 'Nome completo',
                        controller: widget.nomeController,
                        hint: 'João da Silva',
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: CadastrarFuncionarioWebCampo(
                              label: 'CPF',
                              controller: widget.documentoController,
                              hint: '000.000.000-00',
                              textInputAction: TextInputAction.next,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                CpfInputFormatter()
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: CadastrarFuncionarioWebCampo(
                              label: 'Telefone',
                              controller: widget.telefoneController,
                              hint: '(49) 99999-9999',
                              textInputAction: TextInputAction.next,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                TelefoneInputFormatter()
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      CadastrarFuncionarioWebDropdown<Funcao>(
                        label: 'Função',
                        value: _selectedFuncao,
                        items: Funcao.values.map(
                          (f) {
                            return DropdownMenuItem(
                              value: f,
                              child: Text(f.label),
                            );
                          },
                        ).toList(),
                        onChanged: (Funcao? v) {
                          setState(() => _selectedFuncao = v!);
                        },
                        validator: (v) {
                          return v == null ? 'Campo obrigatório' : null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
