import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/components/dialog/dialog_mobile_padrao.dart';

import '../../../../config/routes.dart';
import '../../../components/versao_app.dart';
import '../bloc/login_bloc.dart';
import 'login_mobile_body.dart';

class LoginMobileContent extends StatefulWidget {
  const LoginMobileContent({super.key});

  @override
  State<LoginMobileContent> createState() => _LoginMobileContentState();
}

class _LoginMobileContentState extends State<LoginMobileContent> {
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
            return LoginMobileBody(
              controllerNome: controllerNome,
              controllerSenha: controllerSenha,
              formKey: formKey,
              state: state,
            );
          }

          return const SizedBox.shrink();
        },
      ),
      bottomNavigationBar: const VersaoApp(),
    );
  }

  void _listener(BuildContext context, LoginState state) {
    if (state is LoginAutenticado) {
      Navigator.of(context).pushNamed(AppRoutes.root.route);
    }

    if (state is LoginFail) {
      DialogMobilePadrao.errorDialog(
        context: context,
        message: state.message,
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
