import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/screens/perfis/mobile/perfis_mobile_app_bar.dart';
import 'package:torpheus/presentation/screens/perfis/mobile/perfis_mobile_body.dart';

import '../../../components/dialog/dialog_mobile_padrao.dart';
import '../bloc/perfis_bloc.dart';
import '../bloc/perfis_event.dart';
import '../bloc/perfis_state.dart';

class PerfisMobileContent extends StatefulWidget {
  const PerfisMobileContent({super.key});

  @override
  State<PerfisMobileContent> createState() => _PerfisMobileContentState();
}

class _PerfisMobileContentState extends State<PerfisMobileContent> {
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PerfisMobileAppBar(
          nameController: _nameController,
          formKey: _formKey,
        ),
        backgroundColor: Colors.white,
        body: BlocConsumer<PerfisBloc, PerfisState>(
          listener: _listener,
          buildWhen: _buildWhen,
          builder: (context, state) {
            if (state is PerfisLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is PerfisLoaded) {
              return PerfisMobileBody(state: state);
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  void _listener(BuildContext context, PerfisState state) {
    if (state is PerfisCriado) {
      DialogMobilePadrao.successDialog(
        context: context,
        message: 'Novo perfil criado',
        onPress: () {
          context.read<PerfisBloc>().add(const PerfisLoad());
        },
      );
    }

    if (state is PerfisError) {
      DialogMobilePadrao.errorDialog(
        context: context,
        message: state.message,
        onPress: () {},
      );
    }

    if (state is PerfisExcluido) {
      DialogMobilePadrao.successDialog(
        context: context,
        message: 'Perfil excluído com sucesso!',
        onPress: () {
          context.read<PerfisBloc>().add(const PerfisLoad());
        },
      );
    }
  }

  bool _buildWhen(PerfisState previous, PerfisState current) {
    return current is! PerfisCriado && current is! PerfisError;
  }
}
