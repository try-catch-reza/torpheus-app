import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/enum/documento_tipo.dart';
import '../../../../core/utils/cnpj_input_formatter.dart';
import '../../../../core/utils/cpf_input_formatter.dart';
import '../../../../core/utils/telefone_input_formatter.dart';
import '../bloc/cadastrar_cliente_bloc.dart';
import '../../../components/input_custom.dart';
import '../web/cadastrar_cliente_web_endereco.dart';
import '../web/cadastrar_cliente_web_tipo_documento.dart';

class CadastrarClienteMobileBody extends StatelessWidget {
  const CadastrarClienteMobileBody({
    super.key,
    required this.formKey,
    required this.nomeController,
    required this.documentoController,
    required this.telefoneController,
    required this.emailController,
    required this.cepController,
    required this.logradouroController,
    required this.numeroController,
    required this.complementoController,
    required this.bairroController,
    required this.cidadeController,
    required this.estadoController,
    required this.state,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController nomeController;
  final TextEditingController documentoController;
  final TextEditingController telefoneController;
  final TextEditingController emailController;
  final TextEditingController cepController;
  final TextEditingController logradouroController;
  final TextEditingController numeroController;
  final TextEditingController complementoController;
  final TextEditingController bairroController;
  final TextEditingController cidadeController;
  final TextEditingController estadoController;

  final CadastrarClienteState state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Form(
        key: formKey,
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
                      CadastrarClienteWebTipoDocumento(
                        // selected: state.documentoTipo,
                        selected: state.isEdit
                            ? state.clienteEditar.documentoTipo!
                            : state.documentoTipo,
                        onChanged: (tipo) {
                          documentoController.clear();
                          nomeController.clear();

                          context.read<CadastrarClienteBloc>().add(
                                CadastrarClienteSelecionarDocumento(tipo),
                              );
                        },
                      ),
                      const SizedBox(height: 24),
                      InputCustom(
                        label: state.documentoTipo == DocumentoTipo.cpf
                            ? 'Nome completo'
                            : 'Razão social',
                        controller: nomeController,
                        hint: state.documentoTipo == DocumentoTipo.cpf
                            ? 'João da Silva'
                            : 'Empresa Ltda.',
                        validator: (v) => v == null || v.trim().isEmpty
                            ? 'Campo obrigatório'
                            : null,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: InputCustom(
                              label: state.documentoTipo == DocumentoTipo.cpf
                                  ? 'CPF'
                                  : 'CNPJ',
                              controller: documentoController,
                              hint: state.documentoTipo == DocumentoTipo.cpf
                                  ? '000.000.000-00'
                                  : '00.000.000/0001-00',
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                state.documentoTipo == DocumentoTipo.cpf
                                    ? CpfInputFormatter()
                                    : CnpjInputFormatter(),
                              ],
                              validator: (v) => v == null || v.trim().isEmpty
                                  ? 'Campo obrigatório'
                                  : null,
                              textInputAction: TextInputAction.done,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: InputCustom(
                              label: 'Telefone',
                              controller: telefoneController,
                              hint: '(49) 99999-9999',
                              keyboardType: TextInputType.phone,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                TelefoneInputFormatter(),
                              ],
                              validator: (v) => v == null || v.trim().isEmpty
                                  ? 'Campo obrigatório'
                                  : null,
                              textInputAction: TextInputAction.done,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      InputCustom(
                        label: 'E-mail',
                        controller: emailController,
                        hint: 'cliente@email.com',
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.done,
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
                      const SizedBox(height: 28),
                      const Divider(height: 1, color: Color(0xFFF0F2F5)),
                      CadastrarClienteWebEndereco(
                        cepController: cepController,
                        logradouroController: logradouroController,
                        numeroController: numeroController,
                        complementoController: complementoController,
                        bairroController: bairroController,
                        cidadeController: cidadeController,
                        estadoController: estadoController,
                      ),
                      const SizedBox(height: 28),
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
