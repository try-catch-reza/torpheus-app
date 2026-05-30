import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/screens/funcionario/web/funcionario_web_content.dart';

import '../../../config/responsive.dart';
import 'bloc/funcionario_bloc.dart';
import 'mobile/funcionario_mobile_content.dart';

class FuncionarioScreen extends StatelessWidget {
  const FuncionarioScreen({super.key, required this.funcionarioBloc});

  final FuncionarioBloc funcionarioBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: funcionarioBloc..add(const FuncionarioLoad()),
      child: Responsive.isDesktop(context) || Responsive.isTablet(context)
        ? const FuncionarioWebContent()
        : const FuncionarioMobileContent()
    );
  }
}
