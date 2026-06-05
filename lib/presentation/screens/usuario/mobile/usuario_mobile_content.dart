import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/loading_state.dart';
import '../bloc/usuario_bloc.dart';
import 'usuario_mobile_body.dart';

class UsuarioMobileContent extends StatefulWidget {
  const UsuarioMobileContent({super.key});

  @override
  State<UsuarioMobileContent> createState() => _UsuarioMobileContentState();
}

class _UsuarioMobileContentState extends State<UsuarioMobileContent> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocBuilder<UsuarioBloc, UsuarioState>(
          builder: (context, state) {
            if (state is UsuarioLoading) return const LoadingState();

            if (state is UsuarioLoaded) {
              return UsuarioMobileBody(
                state: state,
                controller: _searchController,
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
