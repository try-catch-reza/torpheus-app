import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/data/models/cliente_model.dart';
import 'package:torpheus/data/models/ordem_servico_model.dart';
import 'package:torpheus/data/models/veiculo_model.dart';
import 'package:torpheus/presentation/screens/ordens_servico/bloc/ordens_servico_bloc.dart';
import 'package:torpheus/presentation/screens/ordens_servico/web/ordens_servico_web_table.dart';

import '../../../../core/constants/color_constants.dart';
import '../../../../data/models/funcionario_model.dart';
import '../../../components/app_cancel_button.dart';
import '../../../components/app_dropdown_field.dart';
import '../../../components/app_primary_button.dart';
import '../../../components/app_text_field.dart';
import '../../../components/lista_vazia_custom.dart';
import '../../../components/search_custom.dart';
import '../../../components/web/header_web_custom.dart';
import 'ordem_servico_web_dialog.dart';

class OrdensServicoWebBody extends StatelessWidget {
  const OrdensServicoWebBody({
    super.key,
    required this.state,
    required this.descricaoController,
    required this.searchController,
    required this.formKey,
  });

  final OrdensServicoState state;
  final TextEditingController descricaoController;
  final TextEditingController searchController;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderWebCustom(
            hasPodeCriar: state.hasPodeCriar,
            title: 'Ordens de Serviço',
            subtitle: 'Gerencie os OS cadastrados no sistema',
            buttonText: 'Cadastrar Ordem',
            onPressed: () => _onShowDialogCadastrarOS(context),
          ),
          SearchCustom(
            controller: searchController,
            hintText: 'Pesquisar por placa',
            onChanged: (value) {
              context.read<OrdensServicoBloc>().add(OrdensServicoSearch(value));
            },
          ),
          if (state.ordensServicoFiltered.isEmpty)
            const ListaVaziaCustom(
              message: 'Nenhuma ordem foi encontrado',
              subMessage: 'Cadastre uma ordem para começar a gerenciar',
            ),
          if (state.ordensServicoFiltered.isNotEmpty)
            Expanded(
              child: OrdensServicoWebTable(
                ordens: state.ordensServicoFiltered,
                onTap: (value) {
                  _showModalServicos(context, value);
                },
              ),
            ),
        ],
      ),
    );
  }

  void _onShowDialogCadastrarOS(BuildContext context) {
    final bloc = context.read<OrdensServicoBloc>();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return BlocProvider.value(
          value: bloc,
          child: BlocBuilder<OrdensServicoBloc, OrdensServicoState>(
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
                                'Cadastrar Ordem',
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
                          AppDropdownField<ClienteModel>(
                            label: 'Cliente',
                            validator: (value) {
                              if (value == null) {
                                return 'Selecione o cliente';
                              }
                              return null;
                            },
                            items: state.clientes.map((cliente) {
                              return DropdownMenuItem(
                                value: cliente,
                                child: Text(cliente.nome ?? ''),
                              );
                            }).toList(),
                            onChanged: (value) {
                              bloc.add(OrdensServicoSetCliente(value!));
                            },
                          ),
                          const SizedBox(height: 16),
                          AppDropdownField<VeiculoModel>(
                            label: 'Veículo',
                            validator: (value) {
                              if (value == null) {
                                return 'Selecione o veículo';
                              }
                              return null;
                            },
                            items: state.veiculos.map((veiculo) {
                              return DropdownMenuItem(
                                value: veiculo,
                                child: Text(
                                  '${veiculo.placa} - ${veiculo.modelo}',
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              bloc.add(OrdensServicoSetVeiculo(value!));
                            },
                          ),
                          const SizedBox(height: 16),
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
                          const SizedBox(height: 32),
                          const Divider(),
                          const SizedBox(height: 16),
                          LayoutBuilder(
                            builder: (context, constraints) {
                              if (constraints.maxWidth < 350) {
                                return state is OrdensServicoSalvando
                                    ? const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : Center(
                                        child: Column(
                                          children: [
                                            AppCancelButton(
                                              text: 'Cancelar',
                                              icon: Icons.close,
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                            ),
                                            const SizedBox(height: 12),
                                            AppPrimaryButton(
                                              text: 'Cadastrar ordem',
                                              icon: Icons.check,
                                              onPressed: () {
                                                _onCadastrarOrdem(
                                                  context,
                                                  bloc,
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                              }

                              return state is OrdensServicoSalvando
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
                                          text: 'Cadastrar ordem',
                                          icon: Icons.check,
                                          onPressed: () {
                                            _onCadastrarOrdem(context, bloc);
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

  void _onCadastrarOrdem(BuildContext context, OrdensServicoBloc bloc) {
    if (formKey.currentState?.validate() ?? false) {
      bloc.add(OrdensServicoSubmit(descricaoController.text));
    }
  }

  void _onAdicionarServico(
    BuildContext context,
    OrdensServicoBloc bloc,
    String id,
  ) {
    if (formKey.currentState?.validate() ?? false) {
      bloc.add(
        OrdensServicoAddServico(
          descricao: descricaoController.text,
          id: id,
        ),
      );
    }
  }

  void _showModalServicos(BuildContext context, OrdemServicoModel ordem) {
    descricaoController.clear();
    final bloc = context.read<OrdensServicoBloc>();

    showDialog(
      context: context,
      barrierColor: Colors.black54,
      barrierDismissible: true,
      builder: (dialogContext) => OrdemServicoWebDialog(
        ordem: ordem,
        onAdicionar: () => _onShowDialogAdicionar(
          dialogContext,
          bloc,
          ordem.id ?? '',
        ),
        onRemover: (s) => {},
      ),
    );
  }

  void _onShowDialogAdicionar(
    BuildContext context,
    OrdensServicoBloc bloc,
    String id,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return BlocProvider.value(
          value: bloc,
          child: BlocBuilder<OrdensServicoBloc, OrdensServicoState>(
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
                              OrdensServicoSetFuncionario(value!),
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
                actions: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: ElevatedButton.icon(
                        onPressed: () => _onAdicionarServico(context, bloc, id),
                        icon: const Icon(Icons.check, size: 20),
                        label: const Text('Adicionar serviço'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
