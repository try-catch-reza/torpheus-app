import 'package:flutter/material.dart';

import '../../../../core/constants/custom_colors.dart';

class CadastrarClienteMobileFooter extends StatelessWidget {
  const CadastrarClienteMobileFooter({
    super.key,
    required this.isEdit,
    required this.isLoading,
    required this.onCadastrar,
  });

  final bool isEdit;
  final bool isLoading;
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
            : Text(
                isEdit
                    ? 'Atualizar os dados do cliente'
                    : 'Adicionar novo cliente',
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }
}
