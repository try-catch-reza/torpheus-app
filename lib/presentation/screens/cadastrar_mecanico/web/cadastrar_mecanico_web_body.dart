import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/mecanico_model.dart';
import '../../../components/formatadores.dart';
import '../bloc/cadastrar_mecanico_bloc.dart';
import 'cadastrar_funcionario_web_dropdown.dart';
import 'cadastrar_funcionario_web_footer.dart';
import 'cadastrar_mecanico_web_campo.dart';
import 'cadastrar_mecanico_web_header.dart';
import 'package:torpheus/core/constants/enum/funcao.dart';

class CadastrarMecanicoWebBody extends StatefulWidget {
  const CadastrarMecanicoWebBody({
    super.key,
    required this.state,
    required this.formKey,
    required this.nomeController,
    required this.documentoController,
    required this.telefoneController,
  });

  final CadastrarMecanicoState state;
  final GlobalKey<FormState> formKey;
  final TextEditingController nomeController;
  final TextEditingController documentoController;
  final TextEditingController telefoneController;

  @override
  State<CadastrarMecanicoWebBody> createState() =>
      _CadastrarMecanicoWebBodyState();
}

class _CadastrarMecanicoWebBodyState extends State<CadastrarMecanicoWebBody> {
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
            const CadastrarMecanicoWebHeader(),
            const SizedBox(height: 28),
            Expanded(
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFEAEDF2)),
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
                            const SizedBox(width: 16),
                            Expanded(
                              child: CadastrarFuncionarioWebDropdown<Funcao>(
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
                            ),
                          ],
                        ),
                        CadastrarFuncionarioWebFooter(
                          onCadastrar: () {
                            if (widget.formKey.currentState!.validate()) {
                              final funcionario = FuncionarioModel(
                                nome: widget.nomeController.text,
                                documento: widget.documentoController.text,
                                telefone: widget.telefoneController.text,
                                funcao: _selectedFuncao.label,
                              );

                              context.read<CadastrarMecanicoBloc>().add(
                                    CadastrarMecanicoSubmit(
                                      funcionario: funcionario,
                                    ),
                                  );
                            }
                          },
                          onCancelar: () {},
                          isLoading: widget.state is CadastrarMecanicoLoading,
                        ),
                      ],
                    ),
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
