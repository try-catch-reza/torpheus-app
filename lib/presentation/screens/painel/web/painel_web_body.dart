import 'package:flutter/material.dart';
import 'package:torpheus/presentation/screens/painel/web/painel_web_dashboard.dart';
import 'package:torpheus/presentation/screens/painel/widgets/painel_title.dart';

class PainelWebBody extends StatelessWidget {
  const PainelWebBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(32.0),
      child: Padding(
        padding: EdgeInsets.only(
          bottom: 24.0,
          left: 20,
          right: 20,
          top: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PainelTitle(),
            SizedBox(height: 24),
            PainelWebDashboard(),
          ],
        ),
      ),
    );
  }
}
