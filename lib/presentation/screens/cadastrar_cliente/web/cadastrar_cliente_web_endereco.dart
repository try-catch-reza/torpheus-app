import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/cep_input_formatter.dart';
import '../../../components/app_text_field.dart';
import '../../../components/section_label.dart';
import '../bloc/cadastrar_cliente_bloc.dart';

class CadastrarClienteWebEndereco extends StatelessWidget {
  const CadastrarClienteWebEndereco({
    super.key,
    required this.cepController,
    required this.logradouroController,
    required this.numeroController,
    required this.complementoController,
    required this.bairroController,
    required this.cidadeController,
    required this.estadoController,
  });

  final TextEditingController cepController;
  final TextEditingController logradouroController;
  final TextEditingController numeroController;
  final TextEditingController complementoController;
  final TextEditingController bairroController;
  final TextEditingController cidadeController;
  final TextEditingController estadoController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionLabel('ENDEREÇO'),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 180,
              child: AppTextField(
                label: 'CEP',
                controller: cepController,
                hint: '00000-000',
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CepInputFormatter(),
                ],
                validator: (v) {
                  return v == null || v.trim().isEmpty
                      ? 'Campo obrigatório'
                      : null;
                },
                onChange: (cep) {
                  if (cep.length == 9) {
                    context
                        .read<CadastrarClienteBloc>()
                        .add(CadastrarClienteSetCEP(cep));
                  }

                  if (cep.length < 9) {
                    logradouroController.clear();
                    numeroController.clear();
                    complementoController.clear();
                    bairroController.clear();
                    cidadeController.clear();
                    estadoController.clear();
                  }
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        AppTextField(
          label: 'Logradouro',
          controller: logradouroController,
          hint: 'Rua, avenida, rodovia...',
          validator: (v) =>
              v == null || v.trim().isEmpty ? 'Campo obrigatório' : null,
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 180,
              child: AppTextField(
                label: 'Número',
                controller: numeroController,
                hint: '123',
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                validator: (v) {
                  return v == null || v.trim().isEmpty
                      ? 'Campo obrigatório'
                      : null;
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: AppTextField(
                label: 'Complemento',
                controller: complementoController,
                hint: 'Apto, sala, bloco (opcional)',
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: AppTextField(
                label: 'Bairro',
                controller: bairroController,
                hint: 'Centro',
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Campo obrigatório' : null,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: AppTextField(
                label: 'Cidade',
                controller: cidadeController,
                hint: 'Chapecó',
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Campo obrigatório' : null,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: AppTextField(
                label: 'Estado',
                controller: estadoController,
                hint: 'SC',
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Campo obrigatório' : null,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
