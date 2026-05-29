import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:torpheus/presentation/components/formatadores.dart';
import 'package:torpheus/presentation/screens/cadastrar_mecanico/bloc/cadastrar_mecanico_bloc.dart';
import 'package:torpheus/presentation/screens/cadastrar_mecanico/web/cadastrar_mecanico_web_campo.dart';

import '../../../../core/constants/enum/funcao.dart';
import '../web/cadastrar_funcionario_web_dropdown.dart';

class CadastrarMecanicoMobileBody extends StatefulWidget {
  const CadastrarMecanicoMobileBody({
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

  final CadastrarMecanicoState state;

  @override
  State<CadastrarMecanicoMobileBody> createState() =>
      _CadastrarMecanicoMobileBodyState();
}

class _CadastrarMecanicoMobileBodyState
    extends State<CadastrarMecanicoMobileBody> {
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
                      CadastrarMecanicoWebCampo(
                        label: 'Nome completo',
                        controller: widget.nomeController,
                        hint: 'João da Silva',
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: CadastrarMecanicoWebCampo(
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
                            child: CadastrarMecanicoWebCampo(
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
