import 'package:flutter/material.dart';

import '../../../../core/constants/custom_colors.dart';

class CadastrarClienteWebFooter extends StatelessWidget {
  const CadastrarClienteWebFooter({
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
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Color(0xFFF0F2F5)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            height: 40,
            child: OutlinedButton(
              onPressed: isLoading ? null : onCancelar,
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF6B7A99),
                side: const BorderSide(color: Color(0xFFDDE1EA)),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Cancelar',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            height: 40,
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
                      'Cadastrar cliente',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.none,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
