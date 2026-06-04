import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/components/loading_state.dart';

import '../bloc/funcionario_bloc.dart';
import 'funcionario_mobile_body.dart';

class FuncionarioMobileContent extends StatefulWidget {
  const FuncionarioMobileContent({super.key});

  @override
  State<FuncionarioMobileContent> createState() => _FuncionarioMobileContentState();
}

class _FuncionarioMobileContentState extends State<FuncionarioMobileContent> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocBuilder<FuncionarioBloc, FuncionarioState>(
          builder: (context, state) {
            if (state is FuncionarioLoading) {
              return const LoadingState();
            }

            if (state is FuncionarioLoaded) {
              return FuncionarioMobileBody(
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
