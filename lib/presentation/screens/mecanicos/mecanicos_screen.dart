import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/screens/mecanicos/bloc/mecanicos_bloc.dart';
import 'package:torpheus/presentation/screens/mecanicos/web/mecanicos_web_content.dart';

import '../../../config/responsive.dart';
import 'mobile/mecanicos_mobile_content.dart';

class MecanicosScreen extends StatelessWidget {
  const MecanicosScreen({super.key, required this.mecanicosBloc});

  final MecanicosBloc mecanicosBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: mecanicosBloc..add(const MecanicosLoad()),
      child: Responsive.isDesktop(context) || Responsive.isTablet(context)
        ? const MecanicosWebContent()
        : const MecanicosMobileContent()
    );
  }
}
