import 'package:flutter/material.dart';

class GradientLine extends StatelessWidget {
  const GradientLine({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 4.0,
      width: 30,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFFF8F71),
            Color(0xFFEF2D1A),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
    );
  }
}
