import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/components/dialog/dialog_web_padrao.dart';
import 'package:torpheus/presentation/screens/perfis/bloc/perfis_bloc.dart';
import 'package:torpheus/presentation/screens/perfis/bloc/perfis_event.dart';
import 'package:torpheus/presentation/screens/perfis/bloc/perfis_state.dart';
import 'package:torpheus/presentation/screens/perfis/web/perfis_web_body.dart';

class PerfisWebContent extends StatefulWidget {
  const PerfisWebContent({super.key});

  @override
  State<PerfisWebContent> createState() => _PerfisWebContentState();
}

class _PerfisWebContentState extends State<PerfisWebContent> {
  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            return PerfisWebBody(
              state: state,
              formKey: _formKey,
              descController: _descController,
              nameController: _nameController,
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  void _listener(BuildContext context, PerfisState state) {
    if (state is PerfisCriado) {
      DialogWebPadrao.successDialog(
        context: context,
        message: 'Novo perfil criado',
        onPress: () {
          context.read<PerfisBloc>().add(const PerfisLoad());
        },
      );
    }

    if (state is PerfisError) {
      DialogWebPadrao.errorDialog(
        context: context,
        message: state.message,
        onPress: () {},
      );
    }
  }

  bool _buildWhen(PerfisState previous, PerfisState current) {
    return current is! PerfisCriado && current is! PerfisError;
  }
}
