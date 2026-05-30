import 'package:flutter/material.dart';
import 'package:torpheus/config/responsive.dart';
import 'package:torpheus/presentation/screens/cadastrar_cliente/mobile/cadastrar_cliente_mobile_content.dart';
import 'package:torpheus/presentation/screens/cadastrar_cliente/web/cadastrar_cliente_web_content.dart';
import 'bloc/cadastrar_cliente_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CadastrarClienteScreen extends StatelessWidget {
  const CadastrarClienteScreen({
    super.key,
    required this.cadastrarClienteBloc,
    required this.arguments,
  });

  final CadastrarClienteBloc cadastrarClienteBloc;
  final CadastrarClienteArguments arguments;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cadastrarClienteBloc
        ..add(
          CadastrarClienteLoad(
            isEdit: arguments.isEdit,
            clienteId: arguments.clienteId,
          ),
        ),
      child: Responsive.isDesktop(context) || Responsive.isTablet(context)
          ? const CadastrarClienteWebContent()
          : const CadastrarClienteMobileContent(),
    );
  }
}

class CadastrarClienteArguments {
  final bool isEdit;
  final String clienteId;

  CadastrarClienteArguments({this.isEdit = false, this.clienteId = ''});
}
