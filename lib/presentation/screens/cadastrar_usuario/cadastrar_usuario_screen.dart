import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/config/responsive.dart';
import 'package:torpheus/presentation/screens/cadastrar_usuario/bloc/cadastrar_usuario_bloc.dart';
import 'package:torpheus/presentation/screens/cadastrar_usuario/mobile/cadastrar_usuario_mobile_content.dart';

class CadastrarUsuarioScreen extends StatelessWidget {
  const CadastrarUsuarioScreen({
    super.key,
    required this.cadastrarUsuarioBloc,
    required this.arguments,
  });

  final CadastrarUsuarioBloc cadastrarUsuarioBloc;
  final CadastrarUsuarioArguments arguments;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cadastrarUsuarioBloc
        ..add(
          CadastrarUsuarioLoad(
            isEdit: arguments.isEdit,
            usuarioId: arguments.usuarioId,
          ),
        ),
      child: Responsive.isDesktop(context) || Responsive.isTablet(context)
          ? const CadastrarUsuarioMobileContent()
          : const CadastrarUsuarioMobileContent(),
    );
  }
}

class CadastrarUsuarioArguments {
  final bool isEdit;
  final String usuarioId;

  CadastrarUsuarioArguments({this.isEdit = false, this.usuarioId = ''});
}

