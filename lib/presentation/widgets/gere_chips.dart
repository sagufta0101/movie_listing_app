import 'package:flutter/material.dart';

class GradientBorderPainter extends CustomPainter {
  final BorderRadius borderRadius;
  final LinearGradient gradient;
  final double strokeWidth;

  GradientBorderPainter({
    required this.borderRadius,
    required this.gradient,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var rect = Offset.zero & size;
    var outerRRect = borderRadius.toRRect(rect);
    var innerRRect = outerRRect.deflate(strokeWidth);

    var paint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawDRRect(outerRRect, innerRRect, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => oldDelegate != this;
}

class GenreChip extends StatelessWidget {
  final String genre;

  const GenreChip({
    Key? key,
    required this.genre,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: GradientBorderPainter(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
          colors: [Colors.white54, Colors.white12],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        strokeWidth: 1,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 15, vertical: 8), // Padding for the stroke
        child: IntrinsicHeight(
          child: IntrinsicWidth(
            child: Center(
              child: Text(
                genre,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
      // Chip(
      //   labelPadding: const EdgeInsets.symmetric(horizontal: 8.0),
      //   label: Text(
      //     genre,
      //     style: const TextStyle(color: Colors.white),
      //   ),
      //   elevation: 2,
      //   backgroundColor: Colors.grey.shade900,
      //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      // ),
    );
  }
}
