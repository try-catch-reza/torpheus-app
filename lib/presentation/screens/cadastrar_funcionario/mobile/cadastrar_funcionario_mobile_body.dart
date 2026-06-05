import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/core/constants/enum/funcao.dart';
import 'package:torpheus/data/models/usuario_model.dart';
import 'package:torpheus/presentation/components/app_dropdown_field.dart';
import 'package:torpheus/presentation/components/app_text_field.dart';

import '../../../../core/utils/cpf_input_formatter.dart';
import '../../../../core/utils/telefone_input_formatter.dart';
import '../bloc/cadastrar_funcionario_bloc.dart';

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
                      AppTextField(
                        label: 'Nome completo',
                        controller: widget.nomeController,
                        hint: 'João da Silva',
                        validator: (p0) {
                          if (p0 == null || p0.isEmpty) {
                            return 'Campo obrigatório';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.text,
                      ),
                      const SizedBox(height: 16),
                      AppTextField(
                        label: 'CPF',
                        controller: widget.documentoController,
                        hint: '000.000.000-00',
                        validator: (p0) {
                          if (p0 == null || p0.isEmpty) {
                            return 'Campo obrigatório';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CpfInputFormatter()
                        ],
                      ),
                      const SizedBox(height: 16),
                      AppTextField(
                        label: 'Telefone',
                        controller: widget.telefoneController,
                        hint: '(00) 00000-0000',
                        validator: (p0) {
                          if (p0 == null || p0.isEmpty) {
                            return 'Campo telefone é obrigatório';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          TelefoneInputFormatter(),
                        ],
                      ),
                      const SizedBox(height: 16),
                      AppDropdownField<Funcao>(
                        label: 'Função',
                        validator: (p0) {
                          if (p0 == null) {
                            return 'Selecione a função do funcionário';
                          }
                          return null;
                        },
                        items: Funcao.values.map((funcao) {
                          return DropdownMenuItem(
                            value: funcao,
                            child: Text(funcao.label),
                          );
                        }).toList(),
                        onChanged: (value) {
                          context.read<CadastrarFuncionarioBloc>().add(
                                CadastrarFuncionarioSetFuncao(value!),
                              );
                        },
                      ),
                      const SizedBox(height: 16),
                      AppDropdownField<UsuarioModel>(
                        label: 'Usuário',
                        validator: (p0) {
                          if (p0 == null) {
                            return 'Selecione o usuario para '
                                'atribuir a esse funcionário';
                          }
                          return null;
                        },
                        items: widget.state.usuarios.map((usuario) {
                          return DropdownMenuItem(
                            value: usuario,
                            child: Text('${usuario.nome}'),
                          );
                        }).toList(),
                        onChanged: (value) {
                          context.read<CadastrarFuncionarioBloc>().add(
                                CadastrarFuncionarioSetUsuario(value!),
                              );
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
