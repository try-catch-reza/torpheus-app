import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/components/app_bar_padrao.dart';
import 'package:torpheus/presentation/components/app_button_bottom_navigation.dart';
import 'package:torpheus/presentation/components/dialog/dialog_mobile_padrao.dart';
import 'package:torpheus/presentation/components/loading_state.dart';
import 'package:torpheus/presentation/screens/cadastrar_usuario/bloc/cadastrar_usuario_bloc.dart';
import 'package:torpheus/presentation/screens/cadastrar_usuario/mobile/cadastrar_usuario_mobile_body.dart';

class CadastrarUsuarioMobileContent extends StatefulWidget {
  const CadastrarUsuarioMobileContent({super.key});

  @override
  State<CadastrarUsuarioMobileContent> createState() =>
      _CadastrarUsuarioMobileContentState();
}

class _CadastrarUsuarioMobileContentState
    extends State<CadastrarUsuarioMobileContent> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarPadrao(
        title: 'Cadastrar Usuário',
        hasLeading: true,
      ),
      body: BlocConsumer<CadastrarUsuarioBloc, CadastrarUsuarioState>(
        buildWhen: _buildWhen,
        listener: _listener,
        builder: (context, state) {
          if (state is CadastrarUsuarioLoading) {
            return const LoadingState();
          }

          if (state is CadastrarUsuarioLoaded) {
            return CadastrarUsuarioMobileBody(
              formKey: _formKey,
              nomeController: _nomeController,
              emailController: _emailController,
              senhaController: _senhaController,
              state: state,
            );
          }

          return const SizedBox.shrink();
        },
      ),
      bottomNavigationBar: AppButtonBottomNavigation(
        onPressed: () => _onSalvarUsuario(context),
        text: 'Salvar novo usuário',
        icon: Icons.check,
      ),
    );
  }

  bool _buildWhen(
    CadastrarUsuarioState previous,
    CadastrarUsuarioState current,
  ) {
    return current is! CadastrarUsuarioError &&
        current is! CadastrarUsuarioSuccess;
  }

  void _listener(BuildContext context, CadastrarUsuarioState state) {
    if (state is CadastrarUsuarioSuccess) {
      DialogMobilePadrao.successDialog(
        context: context,
        message: 'Usuário cadastrado com sucesso!',
        onPress: () {
          Navigator.of(context).pop();
        },
      );
    }

    if (state is CadastrarUsuarioError) {
      DialogMobilePadrao.errorDialog(
        context: context,
        message: state.message,
        onPress: () {},
      );
    }
  }

  void _onSalvarUsuario(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<CadastrarUsuarioBloc>().add(
            CadastrarUsuarioSubmit(
              senha: _senhaController.text,
              nome: _nomeController.text,
              email: _emailController.text,
            ),
          );
    }
  }
}
