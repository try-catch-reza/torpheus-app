import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/components/app_bar_padrao.dart';
import 'package:torpheus/presentation/screens/veiculos/mobile/veiculos_mobile_body.dart';

import '../../../components/loading_state.dart';
import '../bloc/veiculos_bloc.dart';

class VeiculosMobileContent extends StatefulWidget {
  const VeiculosMobileContent({super.key});

  @override
  State<VeiculosMobileContent> createState() => _VeiculosMobileContentState();
}

class _VeiculosMobileContentState extends State<VeiculosMobileContent> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarPadrao(title: 'Veículos'),
      body: BlocBuilder<VeiculosBloc, VeiculosState>(
        builder: (context, state) {
          if (state is VeiculosLoading) {
            return const LoadingState();
          }

          if (state is VeiculosLoaded) {
            return VeiculosMobileBody(
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
