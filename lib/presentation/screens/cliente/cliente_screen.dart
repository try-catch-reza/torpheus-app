import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/screens/cliente/bloc/cliente_bloc.dart';

import 'package:torpheus/presentation/screens/cliente/web/cliente_web_content.dart';
import 'package:torpheus/presentation/screens/cliente/mobile/cliente_mobile_content.dart';

import '../../../config/responsive.dart';

class ClienteScreen extends StatelessWidget {
  const ClienteScreen({super.key, required this.clienteBloc});

  final ClienteBloc clienteBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: clienteBloc..add(const ClientesLoad()),
      child: Responsive.isDesktop(context) || Responsive.isTablet(context)
          ? const ClienteWebContent()
          : const ClienteMobileContent(),
    );
  }
}
