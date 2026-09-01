import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Fixed 24px dot-matrix texture that sits behind all page content, echoing the
/// "Depth Pattern" from the Kinetic Logic design system.
class DotGridBackground extends StatelessWidget {
  const DotGridBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        child: CustomPaint(painter: _DotGridPainter()),
      ),
    );
  }
}

class _DotGridPainter extends CustomPainter {
  static const double _spacing = 24;
  static const double _radius = 1;

  final Paint _dot = Paint()..color = AppColors.onSurface.withValues(alpha: 0.05);

  @override
  void paint(Canvas canvas, Size size) {
    for (double y = 0; y < size.height; y += _spacing) {
      for (double x = 0; x < size.width; x += _spacing) {
        canvas.drawCircle(Offset(x, y), _radius, _dot);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DotGridPainter oldDelegate) => false;
}
