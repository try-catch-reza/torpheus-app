import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/core/utils/placa_input_formatter.dart';
import 'package:torpheus/presentation/screens/cadastrar_veiculo/bloc/cadastrar_veiculo_bloc.dart';

import '../../../../core/constants/lista_dropdown.dart';
import '../../../components/app_dropdown_field.dart';
import '../../../components/app_text_field.dart';

class CadastrarVeiculoBody extends StatelessWidget {
  const CadastrarVeiculoBody({
    super.key,
    required this.formKey,
    required this.placaController,
    required this.modeloController,
    required this.motorController,
    required this.anoController,
    required this.state,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController placaController;
  final TextEditingController modeloController;
  final TextEditingController motorController;
  final TextEditingController anoController;
  final CadastrarVeiculoState state;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
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
              AppDropdownField<String>(
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
                  context.read<CadastrarVeiculoBloc>().add(
                        CadastrarVeiculoSetTipo(value ?? ''),
                      );
                },
              ),
              const SizedBox(height: 16),
              AppTextField(
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
              const SizedBox(height: 16),
              AppDropdownField<String>(
                label: 'Marca',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Selecione a marca do veículo';
                  }
                  return null;
                },
                items: ListaDropdown.marcasVeiculo.map((marca) {
                  return DropdownMenuItem(
                    value: marca,
                    child: Text(marca),
                  );
                }).toList(),
                onChanged: (value) {
                  context.read<CadastrarVeiculoBloc>().add(
                        CadastrarVeiculoSetMarca(value ?? ''),
                      );
                },
              ),
              const SizedBox(height: 16),
              AppTextField(
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
              AppTextField(
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
              const SizedBox(height: 16),
              AppDropdownField<String>(
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
                  context.read<CadastrarVeiculoBloc>().add(
                        CadastrarVeiculoSetCambio(value ?? ''),
                      );
                },
              ),
              const SizedBox(height: 16),
              AppTextField(
                controller: anoController,
                label: 'Ano de fabricação',
                hint: '2020',
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(4),
                ],
                validator: (p0) {
                  if (p0 == null || p0.isEmpty) {
                    return 'Digite o ano de fabricação do veículo';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              AppDropdownField<String>(
                label: 'Combustível',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Selecione o combustível do veículo';
                  }
                  return null;
                },
                items: ListaDropdown.combustivel.map((combustivel) {
                  return DropdownMenuItem(
                    value: combustivel,
                    child: Text(combustivel),
                  );
                }).toList(),
                onChanged: (value) {
                  context.read<CadastrarVeiculoBloc>().add(
                        CadastrarVeiculoSetCombustivel(value ?? ''),
                      );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
