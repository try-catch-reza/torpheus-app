import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/cliente_model.dart';
import '../../../../data/models/endereco_model.dart';
import '../bloc/cadastrar_cliente_bloc.dart';
import 'cadastrar_cliente_mobile_footer.dart';

class CadastrarClienteMobileBotoes extends StatelessWidget {
  const CadastrarClienteMobileBotoes({
    super.key,
    required this.formKey,
    required this.nomeController,
    required this.documentoController,
    required this.telefoneController,
    required this.emailController,
    required this.cepController,
    required this.logradouroController,
    required this.numeroController,
    required this.complementoController,
    required this.bairroController,
    required this.cidadeController,
    required this.estadoController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController nomeController;
  final TextEditingController documentoController;
  final TextEditingController telefoneController;
  final TextEditingController emailController;
  final TextEditingController cepController;
  final TextEditingController logradouroController;
  final TextEditingController numeroController;
  final TextEditingController complementoController;
  final TextEditingController bairroController;
  final TextEditingController cidadeController;
  final TextEditingController estadoController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CadastrarClienteBloc, CadastrarClienteState>(
      builder: (context, state) {
        if (state.isEdit) {
          return CadastrarClienteMobileFooter(
            isEdit: true,
            isLoading: state is CadastrarClienteLoading,
            onCadastrar: () => _onUpdate(context, state),
          );
        } else {
          return CadastrarClienteMobileFooter(
            isEdit: false,
            isLoading: state is CadastrarClienteLoading,
            onCadastrar: () => _onCadastrar(context, state),
          );
        }
      },
    );
  }

  void _onUpdate(BuildContext context, CadastrarClienteState state) {
    if (formKey.currentState?.validate() ?? false) {
      EnderecoModel endereco = EnderecoModel(
        rua: logradouroController.text.trim(),
        numero: numeroController.text.trim(),
        complemento: complementoController.text.trim(),
        bairro: bairroController.text.trim(),
        cidade: cidadeController.text.trim(),
        estado: estadoController.text.trim(),
        cep: cepController.text.trim(),
      );

      ClienteModel cliente = ClienteModel(
        endereco: endereco,
        nome: nomeController.text.trim(),
        documento: documentoController.text.trim(),
        telefone: telefoneController.text.trim(),
        email: emailController.text.trim(),
        documentoTipo: state.documentoTipo,
        isActive: state.clienteEditar.isActive,
      );

      context.read<CadastrarClienteBloc>().add(
            CadastrarClienteUpdate(cliente: cliente),
          );
    }
  }

  void _onCadastrar(BuildContext context, CadastrarClienteState state) {
    if (formKey.currentState?.validate() ?? false) {
      EnderecoModel endereco = EnderecoModel(
        rua: logradouroController.text.trim(),
        numero: numeroController.text.trim(),
        complemento: complementoController.text.trim(),
        bairro: bairroController.text.trim(),
        cidade: cidadeController.text.trim(),
        estado: estadoController.text.trim(),
        cep: cepController.text.trim(),
      );

      ClienteModel cliente = ClienteModel(
        endereco: endereco,
        nome: nomeController.text.trim(),
        documento: documentoController.text.trim(),
        telefone: telefoneController.text.trim(),
        email: emailController.text.trim(),
        documentoTipo: state.documentoTipo,
        isActive: true,
      );

      context.read<CadastrarClienteBloc>().add(
            CadastrarClienteSubmit(cliente: cliente),
          );
    }
  }
}
