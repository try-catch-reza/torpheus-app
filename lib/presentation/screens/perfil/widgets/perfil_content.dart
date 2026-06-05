import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/screens/perfil/bloc/perfil_bloc.dart';
import 'package:torpheus/presentation/screens/perfil/widgets/perfil_body.dart';

class PerfilContent extends StatelessWidget {
  const PerfilContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xfff5f5f5),
        body: BlocBuilder<PerfilBloc, PerfilState>(
          builder: (context, state) {
            if (state is PerfilLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is PerfilLoaded) {
              return PerfilBody(state: state);
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
