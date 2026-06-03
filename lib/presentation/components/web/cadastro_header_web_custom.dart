import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/screens/cadastrar_cliente/bloc/cadastrar_cliente_bloc.dart';

import '../../../core/constants/color_constants.dart';
import '../status_toggle.dart';

class CadastroHeaderWebCustom extends StatelessWidget {
  const CadastroHeaderWebCustom({
    super.key,
    required this.onPressed,
    required this.title,
    required this.subTitle,
    required this.isEdit,
    required this.isActive,
  });

  final VoidCallback onPressed;
  final String title;
  final String subTitle;
  final bool isEdit;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 24.0,
        top: 10,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              size: 24,
              color: ColorConstants.chambray,
            ),
            onPressed: onPressed,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1B2A4A),
                  decoration: TextDecoration.none,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subTitle,
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF6B7A99),
                  decoration: TextDecoration.none,
                ),
              ),
            ],
          ),
          const Spacer(),
          StatusToggle(
            isActive: isActive,
            onChanged: (value) {
              context.read<CadastrarClienteBloc>().add(
                    CadastrarClienteSetAtivo(value),
                  );
            },
          ),
        ],
      ),
    );
  }
}
