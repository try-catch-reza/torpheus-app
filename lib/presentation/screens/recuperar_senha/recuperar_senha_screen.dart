import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/screens/recuperar_senha/bloc/recuperar_senha_bloc.dart';

import '../../../config/responsive.dart';
import 'mobile/recuperar_senha_mobile_content.dart';
import 'web/recuperar_senha_web_content.dart';

class RecuperarSenhaScreen extends StatelessWidget {
  const RecuperarSenhaScreen({super.key, required this.recuperarSenhaBloc});

  final RecuperarSenhaBloc recuperarSenhaBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => recuperarSenhaBloc..add(const RecuperarSenhaLoad()),
      child: Responsive.isDesktop(context) || Responsive.isTablet(context)
          ? const RecuperarSenhaWebContent()
          : const RecuperarSenhaMobileContent(),
    );
  }
}
