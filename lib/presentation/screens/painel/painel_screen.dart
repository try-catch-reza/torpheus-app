import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/screens/painel/bloc/painel_bloc.dart';
import 'package:torpheus/presentation/screens/painel/web/painel_web_content.dart';

import '../../../config/responsive.dart';
import 'mobile/painel_mobile_content.dart';

class PainelScreen extends StatelessWidget {
  const PainelScreen({super.key, required this.painelBloc});

  final PainelBloc painelBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: painelBloc..add(const PainelCarregar()),
      child: Responsive.isDesktop(context) || Responsive.isTablet(context)
          ? const PainelWebContent()
          : const PainelMobileContent(),
    );
  }
}
