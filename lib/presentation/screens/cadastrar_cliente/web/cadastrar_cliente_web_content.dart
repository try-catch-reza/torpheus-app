import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/components/dialog/dialog_web_padrao.dart';
import 'package:torpheus/presentation/components/loading_state.dart';
import 'package:torpheus/presentation/screens/cadastrar_cliente/bloc/cadastrar_cliente_bloc.dart';
import 'package:torpheus/presentation/screens/cliente/bloc/cliente_bloc.dart';

import 'cadastrar_cliente_web_body.dart';

class CadastrarClienteWebContent extends StatefulWidget {
  const CadastrarClienteWebContent({super.key});

  @override
  State<CadastrarClienteWebContent> createState() =>
      _CadastrarClienteWebContentState();
}

class _CadastrarClienteWebContentState
    extends State<CadastrarClienteWebContent> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _documentoController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _cepController = TextEditingController();
  final _logradouroController = TextEditingController();
  final _numeroController = TextEditingController();
  final _complementoController = TextEditingController();
  final _bairroController = TextEditingController();
  final _cidadeController = TextEditingController();
  final _estadoController = TextEditingController();

  @override
  void dispose() {
    _nomeController.dispose();
    _documentoController.dispose();
    _telefoneController.dispose();
    _emailController.dispose();
    _cepController.dispose();
    _logradouroController.dispose();
    _numeroController.dispose();
    _complementoController.dispose();
    _bairroController.dispose();
    _cidadeController.dispose();
    _estadoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CadastrarClienteBloc, CadastrarClienteState>(
        buildWhen: _buildWhen,
        listener: _listener,
        builder: (context, state) {
          if (state is CadastrarClienteLoading) {
            return const LoadingState();
          }

          if (state is CadastrarClienteLoaded) {
            return CadastrarClienteWebBody(
              formKey: _formKey,
              nomeController: _nomeController,
              documentoController: _documentoController,
              telefoneController: _telefoneController,
              emailController: _emailController,
              state: state,
              cepController: _cepController,
              logradouroController: _logradouroController,
              numeroController: _numeroController,
              complementoController: _complementoController,
              bairroController: _bairroController,
              cidadeController: _cidadeController,
              estadoController: _estadoController,
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  bool _buildWhen(
    CadastrarClienteState previous,
    CadastrarClienteState current,
  ) {
    return current is! CadastrarClienteSetandoCEP &&
        current is! CadastrarClienteSetadoCEP &&
        current is! CadastrarClienteError &&
        current is! CadastrarClienteSuccess &&
        current is! CadastrarClienteAtualizado;
  }

  void _listener(BuildContext context, CadastrarClienteState state) {
    if (state is CadastrarClienteSetadoCEP) {
      _logradouroController.text = state.endereco.rua ?? '';
      _bairroController.text = state.endereco.bairro ?? '';
      _cidadeController.text = state.endereco.cidade ?? '';
      _estadoController.text = state.endereco.estado ?? '';
    }

    if (state is CadastrarClienteSuccess) {
      DialogWebPadrao.successDialog(
        context: context,
        message: 'Cliente cadastrado com sucesso!',
        onPress: () {

          context.read<CadastrarClienteBloc>().add(
                const CadastrarClienteLoad(isEdit: false, clienteId: ''),
              );
        },
      );
    }

    if (state is CadastrarClienteError) {
      DialogWebPadrao.errorDialog(
        context: context,
        message: state.message,
        onPress: () {
          context.read<CadastrarClienteBloc>().add(
                CadastrarClienteLoad(
                  clienteId: state.clienteId,
                  isEdit: state.isEdit,
                ),
              );
        },
      );
    }

    if (state is CadastrarClienteEditando) {
      _nomeController.text = state.clienteEditar?.nome ?? '';
      _documentoController.text = state.clienteEditar?.documento ?? '';
      _telefoneController.text = state.clienteEditar?.telefone ?? '';
      _emailController.text = state.clienteEditar?.email ?? '';
      _cepController.text = state.clienteEditar?.endereco.cep ?? '';
      _logradouroController.text = state.clienteEditar?.endereco.rua ?? '';
      _numeroController.text = state.clienteEditar?.endereco.numero ?? '';
      _complementoController.text =
          state.clienteEditar?.endereco.complemento ?? '';
      _bairroController.text = state.clienteEditar?.endereco.bairro ?? '';
      _cidadeController.text = state.clienteEditar?.endereco.cidade ?? '';
      _estadoController.text = state.clienteEditar?.endereco.estado ?? '';
    }

    if (state is CadastrarClienteAtualizado) {
      DialogWebPadrao.successDialog(
        context: context,
        message: 'Cliente atualizado com sucesso!',
        onPress: () {
          context.read<ClienteBloc>().add(const ClientesLoad());
        },
      );
    }
  }
}
