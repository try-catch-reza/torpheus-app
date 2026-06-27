import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/screens/servico/servico_screen.dart';

import '../../../../config/routes.dart';
import '../../../../data/models/cliente_model.dart';
import '../../../../data/models/veiculo_model.dart';
import '../../../components/app_dropdown_field.dart';
import '../../../components/app_text_field.dart';
import '../../../components/footer_dialog.dart';
import '../../../components/lista_vazia_custom.dart';
import '../../../components/mobile/app_bar_mobile_search.dart';
import '../../../components/title_dialog.dart';
import '../bloc/ordens_servico_bloc.dart';
import 'ordens_servico_mobile_lista.dart';

class OrdemServicoMobileBody extends StatelessWidget {
  const OrdemServicoMobileBody({
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
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBarMobileSearch(
            onPressed: () => _onShowDialogCadastrarOS(context),
            onChanged: (value) {
              context.read<OrdensServicoBloc>().add(
                    OrdensServicoSearch(value),
                  );
            },
            title: 'Ordem de serviço',
            subtitle: 'Cadastro e histórico de ordem de serviço',
            controller: searchController,
            hasPodeCriar: state.hasPodeCriar,
            hintText: 'Pesquisar por cliente ou placa',
          ),
          if (state.ordensServicoFiltered.isEmpty)
            const ListaVaziaCustom(
              message: 'Nenhuma ordem de serviço encontrado.',
              subMessage: 'Cadastre uma nova ordem de serviço',
            ),
          if (state.ordensServicoFiltered.isNotEmpty)
            OrdensServicoMobileLista(
              ordens: state.ordensServicoFiltered,
              onOrdemTap: (value) {
                Navigator.of(context)
                    .pushNamed(
                  AppRoutes.servico.route,
                  arguments: ServicoArguments(value.id ?? ''),
                )
                    .then((_) {
                  context.read<OrdensServicoBloc>().add(
                        const OrdensServicoLoad(),
                      );
                });
              },
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
                            subTitle: 'Preencha os campos abaixo',
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
