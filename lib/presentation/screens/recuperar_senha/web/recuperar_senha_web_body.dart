import 'package:flutter/material.dart';
import 'package:torpheus/presentation/components/web/web_logo_header.dart';
import 'package:torpheus/presentation/screens/recuperar_senha/web/recupera_senha_web_dicas.dart';
import 'package:torpheus/presentation/screens/recuperar_senha/web/recuperar_senha_web_footer.dart';

import '../../../../core/constants/custom_colors.dart';
import '../widget/recuperar_senha_form.dart';

class RecuperarSenhaWebBody extends StatelessWidget {
  const RecuperarSenhaWebBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.75,
          child: Stack(
            children: [
              Positioned.fill(
                child: ColoredBox(color: ColorConstants.chambray),
              ),
              Positioned.fill(
                child: CustomPaint(painter: _GridPainter()),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 64,
                  vertical: 48,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Spacer(flex: 1),
                    WebLogoHeader(),
                    SizedBox(height: 40),
                    RecuperarSenhaDicas(),
                    Spacer(flex: 2),
                    RecuperarSenhaWebFooter(),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            color: ColorConstants.corFundo,
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 48,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: const RecuperarSenhaForm(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ── Grid painter ──────────────────────────────────────────────────────────────

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = const Color(0xFF243352)
      ..strokeWidth = 0.8
      ..style = PaintingStyle.stroke;

    const spacing = 40.0;

    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), linePaint);
    }
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), linePaint);
    }

    final dotPaint = Paint()
      ..color = const Color(0xFF2D3F60)
      ..style = PaintingStyle.fill;

    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), 1.5, dotPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}