import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/data/models/funcionario_model.dart';
import 'package:torpheus/data/models/servico_model.dart';
import 'package:torpheus/presentation/components/dialog/dialog_confirm.dart';
import 'package:torpheus/presentation/components/lista_vazia_custom.dart';
import 'package:torpheus/presentation/screens/analise_servico/analise_servico_screen.dart';
import 'package:torpheus/presentation/screens/foto/foto_screen.dart';
import 'package:torpheus/presentation/screens/servico/bloc/servico_bloc.dart';
import 'package:torpheus/presentation/screens/servico/mobile/servico_mobile_adicionar.dart';
import 'package:torpheus/presentation/screens/servico/mobile/servico_mobile_list.dart';
import 'package:torpheus/presentation/screens/servico/mobile/servico_mobile_title.dart';

import '../../../../config/routes.dart';
import '../../../../core/constants/enum/status_servico.dart';
import '../../../components/app_dropdown_field.dart';
import '../../../components/app_text_field.dart';
import '../../../components/footer_dialog.dart';
import '../../../components/title_dialog.dart';

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
        Visibility(
          visible: state.hasPodeAdicionarServico && state.hasPodeFinalizarOS,
          child: ServicoMobileAdicionar(
            quantServico: state.ordemServico?.servicos?.length,
            onPressed: () => _onShowDialogAdicionar(context),
            statusOrdem: state.ordemServico?.statusOrdem,
          ),
        ),
        Visibility(
          visible: !state.hasPodeAdicionarServico || !state.hasPodeFinalizarOS,
          child: const SizedBox(
            height: 16,
          ),
        ),
        if (state.ordemServico?.servicos != null &&
            state.ordemServico!.servicos!.isNotEmpty)
          Expanded(
            child: ServicoMobileList(
              hasPodeGerenciaFoto: state.hasPodeFinalizarOS,
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
              onAbrirCamera: (value) {
                Navigator.of(context)
                    .pushNamed(
                  AppRoutes.foto.route,
                  arguments: FotoArguments(
                    ordemServicoId: state.ordemServico?.id ?? '',
                    servico: value,
                  ),
                )
                    .then(
                  (_) {
                    context.read<ServicoBloc>().add(
                          ServicoLoad(
                            ordemServicoId: state.ordemServico?.id ?? '',
                          ),
                        );
                  },
                );
              },
              onCancelar: (value) {
                ConfirmDialog.show(
                  context,
                  titulo: 'Cancelar serviço',
                  mensagem: 'Tem certeza que deseja cancelar esse serviço?',
                  onConfirmar: () {
                    context.read<ServicoBloc>().add(
                          ServicoTrocarStatus(
                            servicoId: value.id ?? '',
                            status: StatusServico.cancelado,
                          ),
                        );
                  },
                  onCancelar: () {},
                );
              },
              onAnalisarServico: (value) {
                Navigator.of(context).pushNamed(
                  AppRoutes.analiseServico.route,
                  arguments: AnaliseServicoArguments(
                    ordemServicoId: state.ordemServico?.id ?? '',
                    servicoId: value.id ?? '',
                  ),
                );
              },
            ),
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

    descricaoController.clear();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return BlocProvider.value(
          value: bloc,
          child: BlocBuilder<ServicoBloc, ServicoState>(
            builder: (context, state) {
              return Dialog(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                insetPadding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 480),
                  child: Padding(
                    padding: const EdgeInsets.all(28),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TitleDialog(
                            title: 'Cadastrar serviço',
                            subTitle: 'Preencha os dados do novo serviço',
                          ),
                          const SizedBox(height: 24),
                          const Divider(height: 1, color: Color(0xFFEEF0F3)),
                          const SizedBox(height: 24),
                          AppTextField(
                            maxLines: 5,
                            controller: descricaoController,
                            label: 'Descrição',
                            hint: 'Barulho na roda dianteira ao passar lombada',
                            validator: (p0) {
                              if (p0 == null || p0.isEmpty) {
                                return 'A descrição é obrigatória';
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
                                child: Text('${funcionario.nome}'),
                              );
                            }).toList(),
                            onChanged: (value) {
                              bloc.add(
                                ServicoSetFuncionario(funcionario: value!),
                              );
                            },
                          ),
                          const SizedBox(height: 28),
                          const Divider(height: 1, color: Color(0xFFEEF0F3)),
                          const SizedBox(height: 20),
                          FooterDialog(
                            label: 'Adicionar serviço',
                            onPressed: () {
                              _onCadastrarServico(context, bloc);
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

  void _onCadastrarServico(BuildContext context, ServicoBloc bloc) {
    if (formKey.currentState?.validate() ?? false) {
      Navigator.of(context).pop();
      bloc.add(ServicoSubmit(descricao: descricaoController.text));
    }
  }

  void _onShowDialogUpdate(BuildContext context, ServicoModel servico) {
    final bloc = context.read<ServicoBloc>();

    descricaoController.text = servico.descricao ?? '';

    final funcionarioSelecionado = state.funcionarios.any(
      (f) => f.id == servico.funcionarioId,
    )
        ? state.funcionarios.firstWhere((f) => f.id == servico.funcionarioId)
        : null;

    if (funcionarioSelecionado != null) {
      bloc.add(
        ServicoSetFuncionario(funcionario: funcionarioSelecionado),
      );
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return BlocProvider.value(
          value: bloc,
          child: BlocBuilder<ServicoBloc, ServicoState>(
            builder: (context, state) {
              return Dialog(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                insetPadding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 480),
                  child: Padding(
                    padding: const EdgeInsets.all(28),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TitleDialog(
                            title: 'Atualizar serviço',
                            subTitle: 'Preencha os dados do serviço',
                          ),
                          const SizedBox(height: 24),
                          const Divider(height: 1, color: Color(0xFFEEF0F3)),
                          const SizedBox(height: 24),
                          AppTextField(
                            maxLines: 5,
                            controller: descricaoController,
                            label: 'Descrição',
                            hint: 'Barulho na roda dianteira ao passar lombada',
                            validator: (p0) {
                              if (p0 == null || p0.isEmpty) {
                                return 'A descrição é obrigatória';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                          ),
                          const SizedBox(height: 16),
                          AppDropdownField<FuncionarioModel>(
                            label: 'Funcionário',
                            value: funcionarioSelecionado,
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
                          const SizedBox(height: 28),
                          const Divider(height: 1, color: Color(0xFFEEF0F3)),
                          const SizedBox(height: 20),
                          FooterDialog(
                            label: 'Atualizar serviço',
                            onPressed: () {
                              _onUpdateServico(
                                context,
                                bloc,
                                servico.id ?? '',
                                funcionarioSelecionado,
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

  void _onUpdateServico(
    BuildContext context,
    ServicoBloc bloc,
    String servicoId,
    FuncionarioModel? funcionario,
  ) {
    if (formKey.currentState?.validate() ?? false) {
      Navigator.of(context).pop();
      bloc.add(
        ServicoUpdate(
          descricao: descricaoController.text,
          servicoId: servicoId,
        ),
      );
    }
  }
}
