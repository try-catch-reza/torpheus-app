import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/components/title_dialog.dart';
import 'package:torpheus/presentation/screens/foto/bloc/foto_bloc.dart';
import 'package:torpheus/presentation/screens/foto/web/foto_web_content.dart';
import 'package:torpheus/presentation/screens/servico/bloc/servico_bloc.dart';
import 'package:torpheus/presentation/screens/servico/web/servico_web_header.dart';
import 'package:torpheus/presentation/screens/servico/web/servico_web_list.dart';
import 'package:torpheus/presentation/screens/servico/web/servico_web_title.dart';

import '../../../../core/constants/enum/status_servico.dart';
import '../../../../data/models/funcionario_model.dart';
import '../../../../data/models/servico_model.dart';
import '../../../../injector.dart';
import '../../../components/app_dropdown_field.dart';
import '../../../components/app_text_field.dart';
import '../../../components/dialog/dialog_confirm.dart';
import '../../../components/footer_dialog.dart';

class ServicoWebBody extends StatelessWidget {
  const ServicoWebBody({
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
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ServicoWebHeader(state: state),
          ServicoWebTitle(ordemServico: state.ordemServico),
          ServicoWebList(
            servicos: state.ordemServico?.servicos?.reversed.toList() ?? [],
            onPressed: () => _onShowDialogAdicionar(context),
            onConcluir: (servico) {
              ConfirmDialog.show(
                context,
                titulo: 'Concluir serviço',
                mensagem: 'Tem certeza que deseja concluir esse serviço?',
                onConfirmar: () {
                  context.read<ServicoBloc>().add(
                        ServicoTrocarStatus(
                          servicoId: servico.id ?? '',
                          status: StatusServico.completado,
                        ),
                      );
                },
                onCancelar: () {},
              );
            },
            onUpdate: (servico) {
              _onShowDialogUpdate(context, servico);
            },
            onReabrir: (servico) {
              ConfirmDialog.show(
                context,
                titulo: 'Reabrir serviço',
                mensagem: 'Tem certeza que deseja reabrir esse serviço?',
                onConfirmar: () {
                  context.read<ServicoBloc>().add(
                        ServicoTrocarStatus(
                          servicoId: servico.id ?? '',
                          status: StatusServico.emProgresso,
                        ),
                      );
                },
                onCancelar: () {},
              );
            },
            onAbrirFotos: (servico) {
              FotoWebContent.show(
                context,
                fotoBloc: getIt.get<FotoBloc>(),
                ordemServicoId: state.ordemServico?.id ?? '',
                servico: servico,
              );
            },
          ),
        ],
      ),
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
              return Dialog(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
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
                              _onUpdateServico(context, bloc, servico.id ?? '');
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
  ) {
    if (formKey.currentState?.validate() ?? false) {
      Navigator.of(context).pop();
      bloc.add(ServicoUpdate(
          descricao: descricaoController.text, servicoId: servicoId));
    }
  }
}
