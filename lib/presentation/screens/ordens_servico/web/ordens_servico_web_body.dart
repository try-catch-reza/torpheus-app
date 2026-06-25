import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/data/models/cliente_model.dart';
import 'package:torpheus/data/models/veiculo_model.dart';
import 'package:torpheus/presentation/screens/ordens_servico/bloc/ordens_servico_bloc.dart';
import 'package:torpheus/presentation/screens/ordens_servico/web/ordens_servico_web_table.dart';

import '../../../components/app_dropdown_field.dart';
import '../../../components/app_text_field.dart';
import '../../../components/footer_dialog.dart';
import '../../../components/lista_vazia_custom.dart';
import '../../../components/search_custom.dart';
import '../../../components/title_dialog.dart';
import '../../../components/web/header_web_custom.dart';

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
                  context
                      .read<OrdensServicoBloc>()
                      .add(OrdensServicoSelecionar(value));
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
                            title: 'Cadastrar ordem de serviço',
                            subTitle: 'Preencha os campos para'
                                ' cadastrar uma nova ordem de serviço',
                          ),
                          const SizedBox(height: 24),
                          const Divider(height: 1, color: Color(0xFFEEF0F3)),
                          const SizedBox(height: 24),
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
                          const SizedBox(height: 28),
                          const Divider(height: 1, color: Color(0xFFEEF0F3)),
                          const SizedBox(height: 20),
                          FooterDialog(
                            label: 'Adicionar serviço',
                            onPressed: () {
                              _onCadastrarOrdem(context, bloc);
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
}
