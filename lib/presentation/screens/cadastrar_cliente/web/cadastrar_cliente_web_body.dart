import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/core/constants/enum/documento_tipo.dart';
import 'package:torpheus/data/models/cliente_model.dart';
import 'package:torpheus/data/models/endereco_model.dart';
import 'package:torpheus/presentation/screens/cadastrar_cliente/bloc/cadastrar_cliente_bloc.dart';
import 'package:torpheus/presentation/screens/cadastrar_cliente/web/cadastrar_cliente_web_tipo_documento.dart';
import 'package:torpheus/presentation/screens/cliente/bloc/cliente_bloc.dart';

import '../../../components/formatadores.dart';
import '../../../components/web/cadastro_header_web_custom.dart';
import '../../../components/input_custom.dart';
import 'cadastrar_cliente_web_endereco.dart';
import 'cadastrar_cliente_web_footer.dart';

class CadastrarClienteWebBody extends StatelessWidget {
  const CadastrarClienteWebBody({
    super.key,
    required this.formKey,
    required this.nomeController,
    required this.documentoController,
    required this.telefoneController,
    required this.emailController,
    required this.state,
    required this.cepController,
    required this.logradouroController,
    required this.numeroController,
    required this.complementoController,
    required this.bairroController,
    required this.cidadeController,
    required this.estadoController,
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
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CadastroHeaderWebCustom(
            title: 'Cadastrar Cliente',
            subTitle: 'Preencha os dados para cadastrar um novo cliente',
            onPressed: () {
              context.read<ClienteBloc>().add(const ClientesLoad());
            },
          ),
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
                      selected: state.documentoTipo,
                      onChanged: (tipo) {
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
                    const SizedBox(height: 24),
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
                    CadastrarClienteWebFooter(
                      isLoading: state is CadastrarClienteLoading,
                      onCancelar: () {
                        context.read<ClienteBloc>().add(const ClientesLoad());
                      },
                      onCadastrar: () {
                        if (formKey.currentState?.validate() ?? false) {
                          EnderecoModel endereco = EnderecoModel(
                            rua: logradouroController.text.trim(),
                            numero: numeroController.text.trim(),
                            complemento: complementoController.text.trim(),
                            bairro: bairroController.text.trim(),
                            cidade: cidadeController.text.trim(),
                            estado: estadoController.text.trim(),
                            cep: cepController.text.trim(),
                          );

                          ClienteModel cliente = ClienteModel(
                            endereco: endereco,
                            nome: nomeController.text.trim(),
                            documento: documentoController.text.trim(),
                            telefone: telefoneController.text.trim(),
                            email: emailController.text.trim(),
                            documentoTipo: state.documentoTipo,
                          );

                          context.read<CadastrarClienteBloc>().add(
                                CadastrarClienteSubmit(cliente: cliente),
                              );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
