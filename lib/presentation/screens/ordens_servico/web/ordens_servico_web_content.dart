import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/components/dialog/dialog_web_padrao.dart';
import 'package:torpheus/presentation/screens/ordens_servico/bloc/ordens_servico_bloc.dart';

import '../../../components/loading_state.dart';
import 'ordens_servico_web_body.dart';

class OrdensServicoWebContent extends StatefulWidget {
  const OrdensServicoWebContent({super.key});

  @override
  State<OrdensServicoWebContent> createState() =>
      _OrdensServicoWebContentState();
}

class _OrdensServicoWebContentState extends State<OrdensServicoWebContent> {
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<OrdensServicoBloc, OrdensServicoState>(
        listener: _listener,
        buildWhen: _buildWhen,
        builder: (context, state) {
          if (state is OrdensServicoLoading) {
            return const LoadingState();
          }

          if (state is OrdensServicoLoaded) {
            return OrdensServicoWebBody(
              formKey: _formKey,
              state: state,
              descricaoController: _descricaoController,
              searchController: _searchController,
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  void _listener(BuildContext context, OrdensServicoState state) {
    if (state is OrdensServicoSalvo) {
      Navigator.of(context).pop();

      DialogWebPadrao.successDialog(
        context: context,
        message: 'Uma nova ordem de serviço foi aberta!',
        onPress: () {
          context.read<OrdensServicoBloc>().add(const OrdensServicoLoad());
        },
      );
    }

    if (state is OrdensServicoError) {
      DialogWebPadrao.errorDialog(
        context: context,
        message: state.message,
        onPress: () {},
      );
    }
  }

  bool _buildWhen(OrdensServicoState previous, OrdensServicoState current) {
    return current is! OrdensServicoError &&
        current is OrdensServicoSalvando &&
        current is OrdensServicoSalvo;
  }
}
