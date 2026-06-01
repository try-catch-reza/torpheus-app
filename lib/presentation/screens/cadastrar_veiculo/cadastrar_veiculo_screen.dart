import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/config/responsive.dart';
import 'package:torpheus/presentation/screens/cadastrar_veiculo/bloc/cadastrar_veiculo_bloc.dart';
import 'package:torpheus/presentation/screens/cadastrar_veiculo/mobile/cadastrar_veiculo_mobile_content.dart';

class CadastrarVeiculoScreen extends StatelessWidget {
  const CadastrarVeiculoScreen({
    super.key,
    required this.cadastrarVeiculoBloc,
    required this.arguments,
  });

  final CadastrarVeiculoBloc cadastrarVeiculoBloc;
  final CadastrarVeiculoArguments arguments;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cadastrarVeiculoBloc
        ..add(
          CadastrarVeiculoLoad(
            isEdit: arguments.isEdit,
            veiculoId: arguments.veiculoId,
          ),
        ),
      child: Responsive.isDesktop(context) || Responsive.isTablet(context)
          ? const CadastrarVeiculoMobileContent()
          : const CadastrarVeiculoMobileContent(),
    );
  }
}

class CadastrarVeiculoArguments {
  final bool isEdit;
  final String veiculoId;

  CadastrarVeiculoArguments({this.isEdit = false, this.veiculoId = ''});
}
