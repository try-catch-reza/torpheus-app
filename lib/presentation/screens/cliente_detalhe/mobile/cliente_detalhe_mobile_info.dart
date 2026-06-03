import 'package:flutter/material.dart';
import 'package:torpheus/core/constants/extension/string_extension.dart';
import 'package:torpheus/data/models/cliente_model.dart';
import 'package:torpheus/presentation/screens/cliente_detalhe/mobile/cliente_detalhe_mobile_tile.dart';

import '../../../../core/constants/color_constants.dart';

class ClienteDetalheMobileInfo extends StatelessWidget {
  const ClienteDetalheMobileInfo({super.key, required this.cliente});

  final ClienteModel? cliente;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      decoration: BoxDecoration(
        border: Border.all(color: ColorConstants.mercury, width: 2.0),
        color: Colors.white,
      ),
      child: Column(
        children: [
          ClienteDetalheMobileTile(
            title: 'Telefone',
            value: cliente?.telefone ?? 'Telefone não informado',
          ),
          ClienteDetalheMobileTile(
            title: 'Email',
            value: cliente?.email ?? 'Email não informado',
          ),
          ClienteDetalheMobileTile(
            title: 'Data de cadastro',
            value: cliente?.createdAt.toString().formataData ??
                'Data de cadastro não informada',
          ),
          ClienteDetalheMobileTile(
            title: 'Rua e número',
            value: cliente?.endereco.labelRuaNumero ??
                'Rua e número não informados',
          ),
          ClienteDetalheMobileTile(
            title: 'Complemento',
            value: cliente?.endereco.complemento ?? 'Complemento não informado',
          ),
          ClienteDetalheMobileTile(
            title: 'Bairro',
            value: cliente?.endereco.bairro ?? 'Bairro não informado',
          ),
          ClienteDetalheMobileTile(
            title: 'Cidade',
            value: cliente?.endereco.cidade ?? 'Cidade não informada',
          ),
          ClienteDetalheMobileTile(
            title: 'Estado',
            value: cliente?.endereco.estado ?? 'Estado não informado',
          ),
          ClienteDetalheMobileTile(
            title: 'CEP',
            value: cliente?.endereco.cep ?? 'CEP não informado',
            isDivider: false,
          ),
        ],
      ),
    );
  }
}
