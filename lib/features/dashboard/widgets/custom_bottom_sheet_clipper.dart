import 'package:flutter/material.dart';

class CustomBottomSheetClipper extends CustomClipper<Path> {
  CustomBottomSheetClipper({
    this.sideCurveStartCord = 50,
    this.topPadding = 30,
    this.centerBumpHeight = -8,
  });

  final double sideCurveStartCord;
  final double topPadding;
  final double centerBumpHeight;

  @override
  Path getClip(Size size) {
    final Path path = Path();

    path.moveTo(0, sideCurveStartCord);
    path.quadraticBezierTo(
      5,
      topPadding, // Control point for the outward curve
      topPadding, topPadding, // End of the curve
    );
    path.lineTo(topPadding, topPadding);
    path.lineTo(size.width / 2 - 35, topPadding);
    path.quadraticBezierTo(
      size.width / 2,
      centerBumpHeight, // Control point for the outward curve
      size.width / 2 + 35, topPadding, // End of the curve
    );
    path.lineTo(size.width - topPadding, topPadding);
    path.quadraticBezierTo(
      size.width - 5,
      topPadding, // Control point (inward curve)
      size.width, sideCurveStartCord, // End of the curve
    );
    path.lineTo(size.width, sideCurveStartCord);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
