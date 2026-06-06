import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/components/app_button_bottom_navigation.dart';
import 'package:torpheus/presentation/screens/cadastrar_veiculo/bloc/cadastrar_veiculo_bloc.dart';

class CadastrarVeiculoMobileButton extends StatelessWidget {
  const CadastrarVeiculoMobileButton({
    super.key,
    required this.formKey,
    required this.placaController,
    required this.modeloController,
    required this.motorController,
    required this.anoController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController placaController;
  final TextEditingController modeloController;
  final TextEditingController motorController;
  final TextEditingController anoController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CadastrarVeiculoBloc, CadastrarVeiculoState>(
      builder: (context, state) {
        if (state.isEdit) {
          return AppButtonBottomNavigation(
            onPressed: () => _onUpdateVeiculo(context),
            icon: Icons.check,
            text: 'Atualizar dados do veículo',
          );
        } else {
          return AppButtonBottomNavigation(
            onPressed: () => _onCadastrarVeiculo(context),
            icon: Icons.check,
            text: 'Adicionar novo veículo',
          );
        }
      },
    );
  }

  void _onCadastrarVeiculo(BuildContext context) {
    if (formKey.currentState?.validate() ?? false) {
      context.read<CadastrarVeiculoBloc>().add(
            CadastrarVeiculoSubmit(
              placa: placaController.text,
              modelo: modeloController.text,
              motor: motorController.text,
              ano: int.tryParse(anoController.text) ?? 0,
            ),
          );
    }
  }

  void _onUpdateVeiculo(BuildContext context) {
    if (formKey.currentState?.validate() ?? false) {
      context.read<CadastrarVeiculoBloc>().add(
            CadastrarVeiculoUpdate(
              placa: placaController.text,
              modelo: modeloController.text,
              motor: motorController.text,
              ano: int.tryParse(anoController.text) ?? 0,
            ),
          );
    }
  }
}
