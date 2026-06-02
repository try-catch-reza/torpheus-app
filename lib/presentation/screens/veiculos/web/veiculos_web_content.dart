import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/components/loading_state.dart';
import 'package:torpheus/presentation/screens/veiculos/bloc/veiculos_bloc.dart';
import 'package:torpheus/presentation/screens/veiculos/web/veiculos_web_body.dart';

class VeiculosWebContent extends StatefulWidget {
  const VeiculosWebContent({super.key});

  @override
  State<VeiculosWebContent> createState() => _VeiculosWebContentState();
}

class _VeiculosWebContentState extends State<VeiculosWebContent> {
  final TextEditingController _searchController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<VeiculosBloc, VeiculosState>(
        builder: (context, state) {
          if (state is VeiculosLoading) {
            return const LoadingState();
          }

          if (state is VeiculosLoaded) {
            return VeiculosWebBody(
              state: state,
              searchController: _searchController,
              formKey: _formKey,
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
