import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/components/dialog/dialog_mobile_padrao.dart';
import 'package:torpheus/presentation/screens/cadastrar_veiculo/bloc/cadastrar_veiculo_bloc.dart';
import 'package:torpheus/presentation/screens/cadastrar_veiculo/mobile/cadastrar_veiculo_mobile_button.dart';

import '../../../components/loading_state.dart';
import 'cadastrar_veiculo_body.dart';
import 'cadastrar_veiculo_mobile_app_bar.dart';

class CadastrarVeiculoMobileContent extends StatefulWidget {
  const CadastrarVeiculoMobileContent({super.key});

  @override
  State<CadastrarVeiculoMobileContent> createState() =>
      _CadastrarVeiculoMobileContentState();
}

class _CadastrarVeiculoMobileContentState
    extends State<CadastrarVeiculoMobileContent> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _placaController = TextEditingController();
  final TextEditingController _modeloController = TextEditingController();
  final TextEditingController _motorController = TextEditingController();
  final TextEditingController _anoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CadastrarVeiculoMobileAppBar(),
      body: BlocConsumer<CadastrarVeiculoBloc, CadastrarVeiculoState>(
        buildWhen: _buildWhen,
        listener: _listener,
        builder: (context, state) {
          if (state is CadastrarVeiculoLoading ||
              state is CadastrarVeiculoEditando) {
            return const LoadingState();
          }

          if (state is CadastrarVeiculoLoaded) {
            return CadastrarVeiculoBody(
              formKey: _formKey,
              placaController: _placaController,
              modeloController: _modeloController,
              motorController: _motorController,
              anoController: _anoController,
              state: state,
            );
          }

          return const SizedBox.shrink();
        },
      ),
      bottomNavigationBar: CadastrarVeiculoMobileButton(
        formKey: _formKey,
        placaController: _placaController,
        modeloController: _modeloController,
        motorController: _motorController,
        anoController: _anoController,
      ),
    );
  }

  void _listener(BuildContext context, CadastrarVeiculoState state) {
    if (state is CadastrarVeiculoSuccess) {
      DialogMobilePadrao.successDialog(
        context: context,
        message: 'Veículo cadastrado com sucesso!',
        onPress: () {
          Navigator.of(context).pop();
        },
      );
    }

    if (state is CadastrarVeiculoError) {
      DialogMobilePadrao.errorDialog(
        context: context,
        message: state.message,
        onPress: () {
          context.read<CadastrarVeiculoBloc>().add(
                CadastrarVeiculoLoad(
                  isEdit: state.isEdit,
                  veiculoId: state.veiculoId,
                ),
              );
        },
      );
    }

    if (state is CadastrarVeiculoEditando) {
      _placaController.text = state.veiculoEditar?.placa ?? '';
      _anoController.text = state.veiculoEditar?.ano.toString() ?? '';
      _motorController.text = state.veiculoEditar?.motor ?? '';
      _modeloController.text = state.veiculoEditar?.modelo ?? '';
    }

    if (state is CadastrarVeiculoAtualizado) {
      DialogMobilePadrao.successDialog(
        context: context,
        message: 'Veículo atualizado com sucesso!',
        onPress: () {
          Navigator.of(context).pop();
        },
      );
    }
  }

  bool _buildWhen(
    CadastrarVeiculoState previous,
    CadastrarVeiculoState current,
  ) {
    return current is! CadastrarVeiculoLoading &&
        current is! CadastrarVeiculoSuccess &&
        current is! CadastrarVeiculoAtualizado;
  }
}
