import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/data/models/veiculo_model.dart';

import '../../../config/responsive.dart';
import 'bloc/veiculo_detalhe_bloc.dart';
import 'mobile/veiculo_detalhe_mobile_content.dart';
import 'web/veiculo_detalhe_web_content.dart';

class VeiculoDetalheScreen extends StatelessWidget {
  const VeiculoDetalheScreen({
    super.key,
    required this.veiculoDetalheBloc,
    required this.arguments,
  });

  final VeiculoDetalheBloc veiculoDetalheBloc;
  final VeiculoDetalheArguments arguments;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: veiculoDetalheBloc..add(VeiculoDetalheLoad(arguments.veiculo)),
      child: Responsive.isDesktop(context) || Responsive.isTablet(context)
          ? const VeiculoDetalheWebContent()
          : const VeiculoDetalheMobileContent(),
    );
  }
}

class VeiculoDetalheArguments {
  VeiculoDetalheArguments({this.veiculo});

  final VeiculoModel? veiculo;
}

