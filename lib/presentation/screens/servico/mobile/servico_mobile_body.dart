import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/data/models/funcionario_model.dart';
import 'package:torpheus/data/models/servico_model.dart';
import 'package:torpheus/presentation/components/dialog/dialog_confirm.dart';
import 'package:torpheus/presentation/components/lista_vazia_custom.dart';
import 'package:torpheus/presentation/screens/servico/bloc/servico_bloc.dart';
import 'package:torpheus/presentation/screens/servico/mobile/servico_mobile_adicionar.dart';
import 'package:torpheus/presentation/screens/servico/mobile/servico_mobile_list.dart';
import 'package:torpheus/presentation/screens/servico/mobile/servico_mobile_title.dart';

import '../../../../core/constants/color_constants.dart';
import '../../../../core/constants/enum/status_servico.dart';
import '../../../components/app_dropdown_field.dart';
import '../../../components/app_text_field.dart';

class ServicoMobileBody extends StatelessWidget {
  const ServicoMobileBody({
    super.key,
    required this.state,
    required this.descricaoController,
    required this.formKey,
  });

  final ServicoState state;
  final TextEditingController descricaoController;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ServicoMobileTitle(ordemServico: state.ordemServico),
        ServicoMobileAdicionar(
          quantServico: state.ordemServico?.servicos?.length,
          onPressed: () => _onShowDialogAdicionar(context),
        ),
        if (state.ordemServico?.servicos != null &&
            state.ordemServico!.servicos!.isNotEmpty)
          ServicoMobileList(
            servicos: state.ordemServico!.servicos!.reversed.toList(),
            onUpdate: (value) {
              _onShowDialogUpdate(context, value);
            },
            onConcluir: (value) {
              ConfirmDialog.show(
                context,
                titulo: 'Concluir serviço',
                mensagem: 'Tem certeza que deseja concluir esse serviço?',
                onConfirmar: () {
                  context.read<ServicoBloc>().add(
                        ServicoTrocarStatus(
                          servicoId: value.id ?? '',
                          status: StatusServico.completado,
                        ),
                      );
                },
                onCancelar: () {},
              );
            },
            onReabrir: (value) {
              ConfirmDialog.show(
                context,
                titulo: 'Reabrir serviço',
                mensagem: 'Tem certeza que deseja reabrir esse serviço?',
                onConfirmar: () {
                  context.read<ServicoBloc>().add(
                        ServicoTrocarStatus(
                          servicoId: value.id ?? '',
                          status: StatusServico.emProgresso,
                        ),
                      );
                },
                onCancelar: () {},
              );
            },
          )
        else
          const ListaVaziaCustom(
            message: 'Nenhum serviço atribuído a essa OS',
            subMessage: 'Adicione um serviço para começar',
          ),
      ],
    );
  }

  void _onShowDialogAdicionar(BuildContext context) {
    final bloc = context.read<ServicoBloc>();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return BlocProvider.value(
          value: bloc,
          child: BlocBuilder<ServicoBloc, ServicoState>(
            builder: (context, state) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Cadastrar serviço',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: ColorConstants.chambray,
                      ),
                    ),
                    IconButton(
                      padding: const EdgeInsets.only(bottom: 5),
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close, size: 24),
                    ),
                  ],
                ),
                content: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppTextField(
                          maxLines: 5,
                          controller: descricaoController,
                          label: 'Descrição',
                          hint: 'Barulho na roda dianteira ao passar lombada',
                          validator: (p0) {
                            if (p0 == null || p0.isEmpty) {
                              return 'A descrição é obrigatório';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.text,
                        ),
                        const SizedBox(height: 16),
                        AppDropdownField<FuncionarioModel>(
                          label: 'Funcionário',
                          items: state.funcionarios.map((funcionario) {
                            return DropdownMenuItem(
                              value: funcionario,
                              child: Text(
                                '${funcionario.nome}',
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            bloc.add(
                              ServicoSetFuncionario(funcionario: value!),
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
                actions: [
                  ElevatedButton.icon(
                    onPressed: () => _onCadastrarServico(context, bloc),
                    icon: const Icon(Icons.check, size: 24),
                    label: const Text('Adicionar serviço'),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  void _onCadastrarServico(BuildContext context, ServicoBloc bloc) {
    if (formKey.currentState?.validate() ?? false) {
      Navigator.of(context).pop();
      bloc.add(ServicoSubmit(descricao: descricaoController.text));
    }
  }

  void _onShowDialogUpdate(BuildContext context, ServicoModel servico) {
    final bloc = context.read<ServicoBloc>();

    descricaoController.text = servico.descricao ?? '';

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return BlocProvider.value(
          value: bloc,
          child: BlocBuilder<ServicoBloc, ServicoState>(
            builder: (context, state) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Atualizar serviço',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: ColorConstants.chambray,
                      ),
                    ),
                    IconButton(
                      padding: const EdgeInsets.only(bottom: 5),
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close, size: 24),
                    ),
                  ],
                ),
                content: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppTextField(
                          maxLines: 5,
                          controller: descricaoController,
                          label: 'Descrição',
                          hint: 'Barulho na roda dianteira ao passar lombada',
                          validator: (p0) {
                            if (p0 == null || p0.isEmpty) {
                              return 'A descrição é obrigatório';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.text,
                        ),
                        const SizedBox(height: 16),
                        AppDropdownField<FuncionarioModel>(
                          label: 'Funcionário',
                          items: state.funcionarios.map((funcionario) {
                            return DropdownMenuItem(
                              value: funcionario,
                              child: Text(
                                '${funcionario.nome}',
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            bloc.add(
                              ServicoSetFuncionario(funcionario: value!),
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
                actions: [
                  ElevatedButton.icon(
                    onPressed: () {
                      _onUpdateServico(
                        context,
                        bloc,
                        servico.id ?? '',
                      );
                    },
                    icon: const Icon(Icons.check, size: 24),
                    label: const Text('Atualizar serviço'),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  void _onUpdateServico(
    BuildContext context,
    ServicoBloc bloc,
    String servicoId,
  ) {
    if (formKey.currentState?.validate() ?? false) {
      Navigator.of(context).pop();
      bloc.add(ServicoUpdate(
          descricao: descricaoController.text, servicoId: servicoId));
    }
  }
}
