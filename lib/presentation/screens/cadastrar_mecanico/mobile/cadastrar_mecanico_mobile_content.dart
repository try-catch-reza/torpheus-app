import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/config/routes.dart';
import 'package:torpheus/presentation/components/dialog/dialog_mobile_padrao.dart';
import 'package:torpheus/presentation/components/loading_state.dart';
import 'package:torpheus/presentation/screens/cadastrar_mecanico/bloc/cadastrar_mecanico_bloc.dart';
import 'package:torpheus/presentation/screens/cadastrar_mecanico/mobile/cadastrar_mecanico_mobile_body.dart';

import '../../../components/app_bar_padrao.dart';
import 'package:torpheus/presentation/screens/cadastrar_mecanico/mobile/cadastrar_mecanico_mobile_botoes.dart';

class CadastrarMecanicoMobileContent extends StatefulWidget {
  const CadastrarMecanicoMobileContent({super.key});

  @override
  State<CadastrarMecanicoMobileContent> createState() =>
      _CadastrarMecanicoMobileContentState();
}

class _CadastrarMecanicoMobileContentState
    extends State<CadastrarMecanicoMobileContent> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _documentoController = TextEditingController();
  final _telefoneController = TextEditingController();

  @override
  void dispose() {
    _nomeController.dispose();
    _documentoController.dispose();
    _telefoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarPadrao(title: "Cadastrar Mecânico"),
      body: BlocConsumer<CadastrarMecanicoBloc, CadastrarMecanicoState>(
        buildWhen: _buildWhen,
        listener: _listener,
        builder: (context, state) {
          if (state is CadastrarMecanicoLoading) {
            return const LoadingState();
          }

          if (state is CadastrarMecanicoLoaded) {
            return CadastrarMecanicoMobileBody(
              formKey: _formKey,
              nomeController: _nomeController,
              documentoController: _documentoController,
              telefoneController: _telefoneController,
              state: state,
            );
          }

          return const SizedBox.shrink();
        },
      ),
      bottomNavigationBar: CadastrarMecanicoMobileBotoes(
        formKey: _formKey,
        nomeController: _nomeController,
        documentoController: _documentoController,
        telefoneController: _telefoneController,

      ),
    );
  }

  bool _buildWhen(
    CadastrarMecanicoState previous,
    CadastrarMecanicoState current,
  ) {
    return current is! CadastrarMecanicoError &&
        current is! CadastrarMecanicoSuccess;
  }

  void _listener(BuildContext context, CadastrarMecanicoState state) {
    if (state is CadastrarMecanicoSuccess) {
      DialogMobilePadrao.successDialog(
        context: context,
        message: 'Mecânico cadastrado com sucesso!',
        onPress: () {
          Navigator.of(context).pushNamed(AppRoutes.mecanicos.route);
        },
      );
    }

    if (state is CadastrarMecanicoError) {
      DialogMobilePadrao.errorDialog(
        context: context,
        message: state.message,
        onPress: () {
          context
              .read<CadastrarMecanicoBloc>()
              .add(const CadastrarMecanicoLoad());
        },
      );
    }
  }
}
