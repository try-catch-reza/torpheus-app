import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/screens/veiculos/bloc/veiculos_bloc.dart';

import 'package:torpheus/presentation/screens/veiculos/web/veiculos_web_content.dart';
import 'package:torpheus/presentation/screens/veiculos/mobile/veiculos_mobile_content.dart';

import '../../../config/responsive.dart';

// Tela de entrada para Veículos. Decide entre versão web e mobile.
class VeiculosScreen extends StatelessWidget {
  const VeiculosScreen({super.key, required this.veiculosBloc});

  final VeiculosBloc veiculosBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: veiculosBloc..add(const VeiculosLoad()),
      child: Responsive.isDesktop(context) || Responsive.isTablet(context)
          ? const VeiculosWebContent()
          : const VeiculosMobileContent(),
    );
  }
}
