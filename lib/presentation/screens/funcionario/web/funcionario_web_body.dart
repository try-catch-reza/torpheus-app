import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/data/models/funcionario_model.dart';
import 'package:torpheus/presentation/components/lista_vazia_custom.dart';

import '../../../../core/constants/color_constants.dart';
import '../../../../core/constants/enum/funcao.dart';
import '../../../../core/utils/cpf_input_formatter.dart';
import '../../../../core/utils/telefone_input_formatter.dart';
import '../../../../data/models/usuario_model.dart';
import '../../../components/app_cancel_button.dart';
import '../../../components/app_dropdown_field.dart';
import '../../../components/app_primary_button.dart';
import '../../../components/app_text_field.dart';
import '../../../components/footer_dialog.dart';
import '../../../components/search_custom.dart';
import '../../../components/title_dialog.dart';
import '../../../components/web/header_web_custom.dart';
import '../bloc/funcionario_bloc.dart';
import 'funcionario_web_table.dart';

class FuncionarioWebBody extends StatelessWidget {
  const FuncionarioWebBody({
    super.key,
    required this.state,
    required this.controller,
    required this.formKey,
    required this.nomeController,
    required this.documentoController,
    required this.telefoneController,
  });

  final FuncionarioState state;
  final TextEditingController controller;
  final GlobalKey<FormState> formKey;
  final TextEditingController nomeController;
  final TextEditingController documentoController;
  final TextEditingController telefoneController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderWebCustom(
            hasPodeCriar: state.hasCriarFuncionario,
            title: 'Funcionários',
            subtitle: 'Cadastro e histórico de funcionários',
            buttonText: 'Cadastrar funcionário',
            onPressed: () => _onShowDialogCadastrarFuncionario(context),
          ),
          SearchCustom(controller: controller),
          if (state.funcionarios.isEmpty)
            const ListaVaziaCustom(
              message: 'Nenhum funcionário encontrado.',
              subMessage: 'Cadastre um novo funcionário',
            ),
          if (state.funcionarios.isNotEmpty)
            Expanded(
              child: FuncionarioWebTable(
                funcionarios: state.funcionarios,
                onTap: state.hasEditarFuncionario
                    ? (value) => _onShowDialogUpdateFuncionario(context, value)
                    : null,
              ),
            ),
        ],
      ),
    );
  }

  void _onShowDialogCadastrarFuncionario(BuildContext context) {
    final bloc = context.read<FuncionarioBloc>();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return BlocProvider.value(
          value: bloc,
          child: BlocBuilder<FuncionarioBloc, FuncionarioState>(
            builder: (context, state) {
              return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                insetPadding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 40,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 480),
                  child: Padding(
                    padding: const EdgeInsets.all(28),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const TitleDialog(
                            title: 'Cadastrar funcionário',
                            subTitle: 'Preencha os dados do funcionário',
                          ),
                          const SizedBox(height: 24),
                          const Divider(height: 1, color: Color(0xFFEEF0F3)),
                          const SizedBox(height: 24),
                          Text(
                            'IDENTIFICAÇÃO',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 16),
                          AppTextField(
                            label: 'Nome completo',
                            controller: nomeController,
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
                            controller: documentoController,
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
                            controller: telefoneController,
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
                              context.read<FuncionarioBloc>().add(
                                    FuncionarioSetFuncao(value!),
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
                            items: state.usuarios.map((usuario) {
                              return DropdownMenuItem(
                                value: usuario,
                                child: Text('${usuario.nome}'),
                              );
                            }).toList(),
                            onChanged: (value) {
                              context.read<FuncionarioBloc>().add(
                                    FuncionarioSetUsuario(value!),
                                  );
                            },
                          ),
                          const SizedBox(height: 24),
                          const Divider(height: 1, color: Color(0xFFEEF0F3)),
                          const SizedBox(height: 24),
                          FooterDialog(
                            label: 'Adicionar funcionário',
                            onPressed: () {
                              _onCadastrarFuncionario(context, bloc);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _onShowDialogUpdateFuncionario(
    BuildContext context,
    FuncionarioModel value,
  ) {
    final bloc = context.read<FuncionarioBloc>();

    bloc.add(FuncionarioSetUpdate(value));

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return BlocProvider.value(
          value: bloc,
          child: BlocBuilder<FuncionarioBloc, FuncionarioState>(
            builder: (context, state) {
              return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Form(
                  key: formKey,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    padding: const EdgeInsets.all(24),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Atualizar funcionário',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  color: ColorConstants.chambray,
                                ),
                              ),
                              IconButton(
                                padding: const EdgeInsets.only(bottom: 5),
                                onPressed: () => Navigator.pop(context),
                                icon: const Icon(Icons.close, size: 30),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Divider(),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'IDENTIFICAÇÃO',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[600],
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    state.funcionarioEditar?.isActive ?? false
                                        ? 'Ativo'
                                        : 'Inativo',
                                    style: const TextStyle(fontSize: 17),
                                  ),
                                  Switch(
                                    value: state.funcionarioEditar?.isActive ??
                                        false,
                                    onChanged: (value) {
                                      context.read<FuncionarioBloc>().add(
                                            const FuncionarioSetAtivo(),
                                          );
                                    },
                                    activeColor: ColorConstants.activeThumb,
                                    activeTrackColor:
                                        ColorConstants.activeBorder,
                                    inactiveThumbColor:
                                        ColorConstants.inactiveThumb,
                                    inactiveTrackColor:
                                        ColorConstants.inactiveBorder,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          AppTextField(
                            label: 'Nome completo',
                            controller: nomeController,
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
                            controller: documentoController,
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
                            controller: telefoneController,
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
                            value: value.funcao,
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
                              context.read<FuncionarioBloc>().add(
                                    FuncionarioSetFuncao(value!),
                                  );
                            },
                          ),
                          const SizedBox(height: 32),
                          const Divider(),
                          const SizedBox(height: 16),
                          LayoutBuilder(
                            builder: (context, constraints) {
                              if (constraints.maxWidth < 350) {
                                return state is FuncionarioSalvando
                                    ? const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : Center(
                                        child: Column(
                                          children: [
                                            AppCancelButton(
                                              text: 'Cancelar',
                                              icon: Icons.close,
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                            const SizedBox(height: 12),
                                            AppPrimaryButton(
                                              text: 'Atualizar funcionário',
                                              icon: Icons.check,
                                              onPressed: () {
                                                _onUpdateFuncionario(
                                                  context,
                                                  bloc,
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                              }

                              return state is FuncionarioSalvando
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        AppCancelButton(
                                          text: 'Cancelar',
                                          icon: Icons.close,
                                          onPressed: () =>
                                              Navigator.pop(context),
                                        ),
                                        const SizedBox(width: 12),
                                        AppPrimaryButton(
                                          text: 'Atualizar funcionário',
                                          icon: Icons.check,
                                          onPressed: () {
                                            _onUpdateFuncionario(
                                              context,
                                              bloc,
                                            );
                                          },
                                        ),
                                      ],
                                    );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _onCadastrarFuncionario(BuildContext context, FuncionarioBloc bloc) {
    if (formKey.currentState?.validate() ?? false) {
      bloc.add(
        FuncionarioSubmit(
          telefone: telefoneController.text,
          documento: documentoController.text,
          nome: nomeController.text,
        ),
      );
    }
  }

  void _onUpdateFuncionario(BuildContext context, FuncionarioBloc bloc) {
    if (formKey.currentState?.validate() ?? false) {
      bloc.add(
        FuncionarioUpdate(
          telefone: telefoneController.text,
          documento: documentoController.text,
          nome: nomeController.text,
        ),
      );
    }
  }
}
