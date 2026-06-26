import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/data/models/servico_model.dart';
import 'package:torpheus/presentation/screens/foto/bloc/foto_bloc.dart';
import 'package:torpheus/presentation/screens/foto/mobile/foto_mobile_content.dart';

class FotoScreen extends StatelessWidget {
  const FotoScreen({
    super.key,
    required this.fotoBloc,
    required this.arguments,
  });

  final FotoBloc fotoBloc;
  final FotoArguments arguments;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: fotoBloc
        ..add(
          FotoCarregar(
            fotosExistentes: arguments.servico.fotos ?? [],
          ),
        ),
      child: FotoMobileContent(
        ordemServicoId: arguments.ordemServicoId,
        servico: arguments.servico,
      ),
    );
  }
}

class FotoArguments {
  const FotoArguments({
    required this.ordemServicoId,
    required this.servico,
  });

  final String ordemServicoId;
  final ServicoModel servico;
}
