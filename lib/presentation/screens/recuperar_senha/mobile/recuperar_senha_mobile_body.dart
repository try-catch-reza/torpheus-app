import 'package:flutter/material.dart';

import '../../../../core/constants/custom_colors.dart';
import '../widget/recuperar_senha_form.dart';

class RecuperarSenhaMobileBody extends StatelessWidget {
  const RecuperarSenhaMobileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: ColoredBox(color: ColorConstants.chambray),
        ),
        Positioned.fill(
          child: CustomPaint(painter: _GridPainter()),
        ),
        SafeArea(
          child: Column(
            children: [
              const _BrandHeader(),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF0F2F5),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(28),
                      topRight: Radius.circular(28),
                    ),
                  ),
                  child: const SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(24, 28, 24, 24),
                    child: RecuperarSenhaForm(),
                  ),
                ),
              ),
            ],
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
      ..strokeWidth = 0.7
      ..style = PaintingStyle.stroke;

    const spacing = 36.0;

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
        canvas.drawCircle(Offset(x, y), 1.3, dotPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ── Brand header ──────────────────────────────────────────────────────────────

class _BrandHeader extends StatelessWidget {
  const _BrandHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 36),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: const Color(0xFF253A60),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFF304D7A)),
            ),
            child: const Icon(
              Icons.build_rounded,
              color: Colors.white,
              size: 28,
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            'TORPHÉUS',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: 3,
              decoration: TextDecoration.none,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Gestão de Oficina Mecânica',
            style: TextStyle(
              fontSize: 11,
              color: Color(0xFF8FA3C0),
              letterSpacing: 1.2,
              decoration: TextDecoration.none,
            ),
          ),
        ],
      ),
    );
  }
}
