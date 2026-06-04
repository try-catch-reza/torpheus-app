import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/screens/perfis/bloc/perfis_bloc.dart';
import 'package:torpheus/presentation/screens/perfis/bloc/perfis_event.dart';
import 'package:torpheus/presentation/screens/perfis/web/perfis_web_content.dart';

class PerfisScreen extends StatelessWidget {
  const PerfisScreen({super.key, required this.perfisBloc});

  final PerfisBloc perfisBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: perfisBloc..add(const PerfisLoad()),
      child: const PerfisWebContent(),
    );
  }
}
