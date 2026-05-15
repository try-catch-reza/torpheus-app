import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/screens/perfil/bloc/perfil_bloc.dart';
import 'package:torpheus/presentation/screens/perfil/widgets/perfil_content.dart';

class PerfilScreen extends StatelessWidget {
  const PerfilScreen({super.key, required this.perfilBloc});

  final PerfilBloc perfilBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: perfilBloc..add(const PerfilLoad()),
      child: const PerfilContent(),
    );
  }
}
