import 'package:flutter/material.dart';

import '../../../../core/constants/custom_colors.dart';

class LoginWebPainelEsquerdo extends StatelessWidget {
  const LoginWebPainelEsquerdo({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      height: height,
      child: Stack(
        children: [
          // ── Fundo azul + grid ───────────────────────────────────────────
          Positioned.fill(
            child: ColoredBox(color: ColorConstants.chambray),
          ),
          Positioned.fill(
            child: CustomPaint(painter: _GridPainter()),
          ),

          // ── Conteúdo ────────────────────────────────────────────────────
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 64, vertical: 48),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(flex: 1),
                _BrandHeader(),
                SizedBox(height: 40),
                _CompanyImageCard(),
                SizedBox(height: 28),
                _FeatureList(),
                Spacer(flex: 2),
                _Footer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Grid painter ─────────────────────────────────────────────────────────────

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

// ── Brand header ─────────────────────────────────────────────────────────────

class _BrandHeader extends StatelessWidget {
  const _BrandHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            color: const Color(0xFF253A60),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFF304D7A)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: const Icon(
            Icons.build_rounded,
            color: Colors.white,
            size: 34,
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'TORPHÉUS',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: Colors.white,
            letterSpacing: 4,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Sistema de Gestão de Oficina Mecânica',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: Color(0xFF8FA3C0),
            letterSpacing: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

// ── Company image card ────────────────────────────────────────────────────────

class _CompanyImageCard extends StatelessWidget {
  const _CompanyImageCard({this.imageUrl});

  /// Passe a URL ou asset da imagem da empresa quando disponível.
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 180,
      constraints: const BoxConstraints(maxWidth: 420),
      decoration: BoxDecoration(
        color: const Color(0xFF253A60),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF304D7A)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: imageUrl != null
            ? Image.network(imageUrl!, fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => const _PlaceholderCompany())
            : const _PlaceholderCompany(),
      ),
    );
  }
}

class _PlaceholderCompany extends StatelessWidget {
  const _PlaceholderCompany();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.directions_car_rounded,
          color: const Color(0xFF8FA3C0).withOpacity(0.45),
          size: 52,
        ),
        const SizedBox(height: 10),
        const Text(
          'Imagem da empresa',
          style: TextStyle(
            fontSize: 12,
            color: Color(0xFF8FA3C0),
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }
}

// ── Feature list ─────────────────────────────────────────────────────────────

class _FeatureList extends StatelessWidget {
  const _FeatureList();

  static const _features = [
    (Icons.receipt_long_rounded, 'Gestão completa de Ordens de Serviço'),
    (Icons.location_on_rounded,  'Rastreamento de veículos em tempo real'),
    (Icons.groups_rounded,       'Controle de equipe e produtividade'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final (icon, label) in _features) ...[
          _FeatureItem(icon: icon, label: label),
          const SizedBox(height: 10),
        ],
      ],
    );
  }
}

class _FeatureItem extends StatelessWidget {
  const _FeatureItem({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 420),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF253A60),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF304D7A)),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF8FA3C0), size: 18),
          const SizedBox(width: 14),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Footer ────────────────────────────────────────────────────────────────────

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(
      fontSize: 11,
      color: Color(0xFF8FA3C0),
      letterSpacing: 0.5,
    );
    const dot = Text(' • ', style: TextStyle(fontSize: 11, color: Color(0xFF4A5E7A)));

    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('v1.0.0', style: style),
        dot,
        Text('UniSenai Chapecó', style: style),
        dot,
        Text('2026', style: style),
      ],
    );
  }
}

