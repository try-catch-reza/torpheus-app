import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/screens/usuario/bloc/usuario_bloc.dart';
import 'package:torpheus/presentation/screens/usuario/web/usuario_web_body.dart';

import '../../../components/dialog/dialog_web_padrao.dart';
import '../../../components/loading_state.dart';

class UsuarioWebContent extends StatefulWidget {
  const UsuarioWebContent({super.key});

  @override
  State<UsuarioWebContent> createState() => _UsuarioWebContentState();
}

class _UsuarioWebContentState extends State<UsuarioWebContent> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<UsuarioBloc, UsuarioState>(
        listener: _listener,
        buildWhen: _buildWhen,
        builder: (context, state) {
          if (state is UsuarioLoading) {
            return const LoadingState();
          }

          if (state is UsuarioLoaded) {
            return UsuarioWebBody(
              state: state,
              searchController: _searchController,
              formKey: _formKey,
              emailController: emailController,
              nomeController: nomeController,
              senhaController: senhaController,
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  void _listener(BuildContext context, UsuarioState state) {
    if (state is UsuarioSalvo) {
      Navigator.of(context).pop();
      DialogWebPadrao.successDialog(
        context: context,
        message: 'Usuário cadastrado com sucesso!',
        onPress: () {
          nomeController.clear();
          emailController.clear();
          senhaController.clear();

          context.read<UsuarioBloc>().add(const UsuariosLoad());
        },
      );
    }

    if (state is UsuarioError) {
      Navigator.of(context).pop();
      DialogWebPadrao.errorDialog(
        context: context,
        message: state.message,
        onPress: () {
          context.read<UsuarioBloc>().add(const UsuariosLoad());
        },
      );
    }

    // if (state is VeiculoAtualizado) {
    //   Navigator.of(context).pop();
    //   DialogWebPadrao.successDialog(
    //     context: context,
    //     message: 'Veículo atualizado com sucesso!',
    //     onPress: () {
    //       _anoController.clear();
    //       _modeloController.clear();
    //       _motorController.clear();
    //       _placaController.clear();
    //
    //       context.read<VeiculosBloc>().add(const VeiculosLoad());
    //     },
    //   );
    // }
  }

  bool _buildWhen(UsuarioState previous, UsuarioState current) {
    return current is! UsuarioSalvando &&
        current is! UsuarioSalvo;
        // current is! UsuarioAtu &&
        // current is! VeiculoAtualizado;
  }
}
