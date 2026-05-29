import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/components/app_bar_padrao.dart';
import 'package:torpheus/presentation/components/loading_state.dart';
import 'package:torpheus/presentation/screens/mecanicos/bloc/mecanicos_bloc.dart';

import 'mecanicos_mobile_body.dart';

class MecanicosMobileContent extends StatefulWidget {
  const MecanicosMobileContent({super.key});

  @override
  State<MecanicosMobileContent> createState() => _MecanicosMobileContentState();
}

class _MecanicosMobileContentState extends State<MecanicosMobileContent> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarPadrao(title: 'Mecânicos'),
      body: BlocBuilder<FuncionarioBloc, MecanicosState>(
        builder: (context, state) {
          if (state is MecanicosLoading) {
            return const LoadingState();
          }

          if (state is MecanicosLoaded) {
            return MecanicosMobileBody(
              state: state,
              controller: _searchController,
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
