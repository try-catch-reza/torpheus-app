import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/core/constants/color_constants.dart';
import 'package:torpheus/core/constants/lista_dropdown.dart';
import 'package:torpheus/presentation/components/web/header_web_custom.dart';
import 'package:torpheus/presentation/screens/veiculos/bloc/veiculos_bloc.dart';

import '../../../../core/utils/placa_input_formatter.dart';
import '../../../components/app_cancel_button.dart';
import '../../../components/app_dropdown_field.dart';
import '../../../components/app_primary_button.dart';
import '../../../components/app_text_field.dart';
import '../../../components/lista_vazia_custom.dart';
import '../../../components/search_custom.dart';
import '../widgets/veiculos_lista.dart';

class VeiculosWebBody extends StatelessWidget {
  const VeiculosWebBody({
    super.key,
    required this.state,
    required this.searchController,
    required this.formKey,
    required this.placaController,
    required this.modeloController,
    required this.motorController,
    required this.anoController,
  });

  final VeiculosState state;
  final TextEditingController searchController;
  final GlobalKey<FormState> formKey;
  final TextEditingController placaController;
  final TextEditingController modeloController;
  final TextEditingController motorController;
  final TextEditingController anoController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderWebCustom(
            title: 'Veículos',
            subtitle: 'Gerencie os veículos cadastrados no sistema',
            buttonText: 'Cadastrar Veículo',
            onPressed: () => _onShowDialogCadastrarVeiculo(context),
          ),
          SearchCustom(
            controller: searchController,
            hintText: 'Pesquisar por placa',
          ),
          if (state.veiculos.isEmpty)
            const ListaVaziaCustom(
              message: 'Nenhum veículo encontrado',
              subMessage: 'Cadastre um novo veículo para começar a gerenciar',
            ),
          if (state.veiculos.isNotEmpty)
            VeiculosLista(
              veiculos: state.veiculos,
              onVeiculoTap: (value) {},
            ),
        ],
      ),
    );
  }

  void _onShowDialogCadastrarVeiculo(BuildContext context) {
    final bloc = context.read<VeiculosBloc>();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return BlocProvider.value(
          value: bloc,
          child: BlocBuilder<VeiculosBloc, VeiculosState>(
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
                                'Cadastrar Veículo',
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
                          Text(
                            'IDENTIFICAÇÃO',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: AppDropdownField<String>(
                                  label: 'Tipo',
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Selecione o tipo do veículo';
                                    }
                                    return null;
                                  },
                                  items: ListaDropdown.tipoVeiculo.map((tipo) {
                                    return DropdownMenuItem(
                                      value: tipo,
                                      child: Text(tipo),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    bloc.add(VeiculoSetTipo(value ?? ''));
                                  },
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: AppTextField(
                                  enabled: state is! VeiculosSalvando,
                                  controller: placaController,
                                  label: 'Placa',
                                  hint: 'ABC-1234 ou ABC1D23',
                                  inputFormatters: [PlacaInputFormatter()],
                                  validator: (p0) {
                                    if (p0 == null || p0.isEmpty) {
                                      return 'Digite a placa do veículo';
                                    }
                                    final raw = p0.replaceAll('-', '');
                                    if (raw.length < 7) {
                                      return 'Placa inválida';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.text,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: AppDropdownField<String>(
                                  label: 'Marca',
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Selecione a marca do veículo';
                                    }
                                    return null;
                                  },
                                  items:
                                      ListaDropdown.marcasVeiculo.map((marca) {
                                    return DropdownMenuItem(
                                      value: marca,
                                      child: Text(marca),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    bloc.add(VeiculoSetMarca(value ?? ''));
                                  },
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: AppTextField(
                                  enabled: state is! VeiculosSalvando,
                                  controller: modeloController,
                                  label: 'Modelo',
                                  hint: 'Uno, Gol...',
                                  validator: (p0) {
                                    if (p0 == null || p0.isEmpty) {
                                      return 'Digite o modelo do veículo';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.text,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Divider(),
                          const SizedBox(height: 16),
                          Text(
                            'ESPECIFICAÇÕES',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: AppTextField(
                                  enabled: state is! VeiculosSalvando,
                                  controller: motorController,
                                  label: 'Motor',
                                  hint: '1.0, 2.0...',
                                  validator: (p0) {
                                    if (p0 == null || p0.isEmpty) {
                                      return 'Digite a cilindrada do motor do veículo';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.text,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: AppDropdownField<String>(
                                  label: 'Câmbio',
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Selecione o tipo de câmbio do veículo';
                                    }
                                    return null;
                                  },
                                  items: ListaDropdown.cambio.map((cambio) {
                                    return DropdownMenuItem(
                                      value: cambio,
                                      child: Text(cambio),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    bloc.add(VeiculoSetCambio(value ?? ''));
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: AppTextField(
                                  enabled: state is! VeiculosSalvando,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(4),
                                  ],
                                  controller: anoController,
                                  label: 'Ano de fabricação',
                                  hint: '2020',
                                  validator: (p0) {
                                    if (p0 == null || p0.isEmpty) {
                                      return 'Digite o ano de fabricação do veículo';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: AppDropdownField<String>(
                                  label: 'Combustível',
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Selecione o combustível do veículo';
                                    }
                                    return null;
                                  },
                                  items: ListaDropdown.combustivel
                                      .map((combustivel) {
                                    return DropdownMenuItem(
                                      value: combustivel,
                                      child: Text(combustivel),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    bloc.add(
                                        VeiculoSetCombustivel(value ?? ''));
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 32),
                          const Divider(),
                          const SizedBox(height: 16),
                          LayoutBuilder(
                            builder: (context, constraints) {
                              if (constraints.maxWidth < 350) {
                                return state is VeiculosSalvando
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
                                              text: 'Cadastrar Veículo',
                                              icon: Icons.check,
                                              onPressed: () {
                                                _onCadastrarVeiculo(
                                                    context, bloc);
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                              }

                              return state is VeiculosSalvando
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
                                          text: 'Cadastrar Veículo',
                                          icon: Icons.check,
                                          onPressed: () {
                                            _onCadastrarVeiculo(context, bloc);
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

  void _onCadastrarVeiculo(BuildContext context, VeiculosBloc bloc) {
    if (formKey.currentState?.validate() ?? false) {
      bloc.add(
        VeiculoSubmit(
          placa: placaController.text,
          modelo: modeloController.text,
          motor: motorController.text,
          ano: anoController.text,
        ),
      );
    }
  }
}
