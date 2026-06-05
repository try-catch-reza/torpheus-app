import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/screens/usuario/bloc/usuario_bloc.dart';
import 'package:torpheus/presentation/screens/usuario/mobile/usuario_mobile_content.dart';

class UsuarioScreen extends StatelessWidget {
  const UsuarioScreen({super.key, required this.usuarioBloc});

  final UsuarioBloc usuarioBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: usuarioBloc..add(const UsuariosLoad()),
      child: const UsuarioMobileContent(),
    );
  }
}
