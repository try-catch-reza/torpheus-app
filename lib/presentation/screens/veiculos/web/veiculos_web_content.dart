import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/components/loading_state.dart';
import 'package:torpheus/presentation/screens/veiculos/bloc/veiculos_bloc.dart';
import 'package:torpheus/presentation/screens/veiculos/web/veiculos_web_body.dart';

import '../../../components/dialog/dialog_mobile_padrao.dart';
import '../../../components/dialog/dialog_web_padrao.dart';

class VeiculosWebContent extends StatefulWidget {
  const VeiculosWebContent({super.key});

  @override
  State<VeiculosWebContent> createState() => _VeiculosWebContentState();
}

class _VeiculosWebContentState extends State<VeiculosWebContent> {
  final TextEditingController _searchController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _placaController = TextEditingController();
  final TextEditingController _modeloController = TextEditingController();
  final TextEditingController _motorController = TextEditingController();
  final TextEditingController _anoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<VeiculosBloc, VeiculosState>(
        listener: _listener,
        buildWhen: _buildWhen,
        builder: (context, state) {
          if (state is VeiculosLoading) {
            return const LoadingState();
          }

          if (state is VeiculosLoaded) {
            return VeiculosWebBody(
              state: state,
              searchController: _searchController,
              formKey: _formKey,
              placaController: _placaController,
              modeloController: _modeloController,
              motorController: _motorController,
              anoController: _anoController,
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  void _listener(BuildContext context, VeiculosState state) {
    if (state is VeiculoSuccess) {
      Navigator.of(context).pop();
      DialogWebPadrao.successDialog(
        context: context,
        message: 'Veículo cadastrado com sucesso!',
        onPress: () {
          _anoController.clear();
          _modeloController.clear();
          _motorController.clear();
          _placaController.clear();
        },
      );
    }

    if (state is VeiculosError) {
      Navigator.of(context).pop();
      DialogMobilePadrao.errorDialog(
        context: context,
        message: state.message,
        onPress: () {
          context.read<VeiculosBloc>().add(
                const VeiculosLoad(),
              );
        },
      );
    }
  }

  bool _buildWhen(
    VeiculosState previous,
    VeiculosState current,
  ) {
    return current is! VeiculosSalvando && current is! VeiculoSuccess;
  }
}
