import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/components/dialog/dialog_web_padrao.dart';

import '../../../../config/routes.dart';
import '../bloc/login_bloc.dart';
import 'login_web_body.dart';

class LoginWebContent extends StatefulWidget {
  const LoginWebContent({super.key});

  @override
  State<LoginWebContent> createState() => _LoginWebContentState();
}

class _LoginWebContentState extends State<LoginWebContent> {
  final TextEditingController controllerNome = TextEditingController();
  final TextEditingController controllerSenha = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: _listener,
        buildWhen: _buildWhen,
        builder: (context, state) {
          if (state is LoginInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is LoginLoaded) {
            return LoginWebBody(
              controllerNome: controllerNome,
              controllerSenha: controllerSenha,
              formKey: formKey,
              state: state,
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  void _listener(BuildContext context, LoginState state) {
    if (state is LoginAutenticado) {
      Navigator.of(context).pushNamed(AppRoutes.root.route);
    }

    if (state is LoginFail) {
      DialogWebPadrao.errorDialog(
        message: state.message,
        context: context,
        onPress: () {},
      );
    }
  }

  bool _buildWhen(LoginState previous, LoginState current) {
    return current is! LoginFail &&
        current is! LoginLoading &&
        current is! LoginAutenticado;
  }
}
