import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/config/responsive.dart';
import 'package:torpheus/presentation/screens/cadastrar_usuario/bloc/cadastrar_usuario_bloc.dart';
import 'package:torpheus/presentation/screens/cadastrar_usuario/mobile/cadastrar_usuario_mobile_content.dart';

class CadastrarUsuarioScreen extends StatelessWidget {
  const CadastrarUsuarioScreen({
    super.key,
    required this.cadastrarUsuarioBloc,
  });

  final CadastrarUsuarioBloc cadastrarUsuarioBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cadastrarUsuarioBloc..add(const CadastrarUsuarioLoad()),
      child: Responsive.isDesktop(context) || Responsive.isTablet(context)
          ? const CadastrarUsuarioMobileContent()
          : const CadastrarUsuarioMobileContent(),
    );
  }
}

