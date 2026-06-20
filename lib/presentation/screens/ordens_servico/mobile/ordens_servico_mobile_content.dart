import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/core/constants/color_constants.dart';
import 'package:torpheus/presentation/components/dialog/dialog_legenda_os.dart';
import 'package:torpheus/presentation/screens/ordens_servico/mobile/ordem_servico_mobile_body.dart';

import '../../../components/dialog/dialog_mobile_padrao.dart';
import '../../../components/loading_state.dart';
import '../bloc/ordens_servico_bloc.dart';

class OrdensServicoMobileContent extends StatefulWidget {
  const OrdensServicoMobileContent({super.key});

  @override
  State<OrdensServicoMobileContent> createState() =>
      _OrdensServicoMobileContentState();
}

class _OrdensServicoMobileContentState
    extends State<OrdensServicoMobileContent> {
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
            return OrdemServicoMobileBody(
              formKey: _formKey,
              state: state,
              descricaoController: _descricaoController,
              searchController: _searchController,
            );
          }

          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => DialogLegendaOS.show(context),
        backgroundColor: ColorConstants.chambray,
        child: const Icon(
          Icons.help_outline,
          color: ColorConstants.mercury,
        ),
      ),
    );
  }

  void _listener(BuildContext context, OrdensServicoState state) {
    if (state is OrdensServicoSalvo) {
      Navigator.of(context).pop();

      DialogMobilePadrao.successDialog(
        context: context,
        message: 'Uma nova ordem de serviço foi aberta!',
        onPress: () {
          context.read<OrdensServicoBloc>().add(const OrdensServicoLoad());
        },
      );
    }

    if (state is OrdensServicoError) {
      DialogMobilePadrao.errorDialog(
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
