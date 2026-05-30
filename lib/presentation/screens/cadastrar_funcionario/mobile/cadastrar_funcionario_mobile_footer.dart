import 'package:flutter/material.dart';

import '../../../../core/constants/custom_colors.dart';

class CadastrarFuncionarioMobileFooter extends StatelessWidget {
  const CadastrarFuncionarioMobileFooter({
    super.key,
    required this.isLoading,
    required this.onCancelar,
    required this.onCadastrar,
  });

  final bool isLoading;
  final VoidCallback onCancelar;
  final VoidCallback onCadastrar;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
      decoration: BoxDecoration(
        color: ColorConstants.chambray,
        border: const Border(
          top: BorderSide(color: Color(0xFFF0F2F5)),
        ),
      ),
      child: ElevatedButton(
        onPressed: isLoading ? null : onCadastrar,
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorConstants.chambray,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : const Text(
                'Cadastrar Funcionário',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.none,
                ),
              ),
      ),
    );
  }
}
