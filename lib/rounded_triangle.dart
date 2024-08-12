library rounded_triangle;

import 'package:flutter/material.dart';
import 'package:rounded_triangle/triangle_painter.dart';

const Color defaultFillColor = Colors.white;
const double defaultIconSize = 48;

/// Create a customised-rounded triangle
///
/// [fillColor] (Optional) Fill color for inside of triangle, defaults to [defaultFillColor]
/// [borderColor] (Optional) Border color for edges of triangle
/// [iconSize] (Optional) Size of triangle container, defaults to [defaultIconSize]
class RoundedTriangle extends StatelessWidget {
  final Color? fillColor;
  final Color? borderColor;
  final double? iconSize;

  const RoundedTriangle({
    super.key,
    this.fillColor = defaultFillColor,
    this.borderColor,
    this.iconSize = defaultIconSize,
  });

  @override
  Widget build(BuildContext context) {
    // Increase icon size by 10% due to painter issues
    final adjustedSize = iconSize! + (iconSize! * 0.1);
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        // Base triangle shape
        SizedBox(
          height: adjustedSize,
          width: adjustedSize,
          child: SizedBox(
              height: adjustedSize,
              width: adjustedSize,
              child: CustomPaint(
                  painter: TrianglePainter(paintingStyle: PaintingStyle.fill, color: fillColor!))),
        ),
        // Draw border if color or thickness has been set
        if (borderColor != null)
          SizedBox(
              height: adjustedSize,
              width: adjustedSize,
              child: SizedBox(
                  height: adjustedSize,
                  width: adjustedSize,
                  child: CustomPaint(
                      painter: TrianglePainter(
                          paintingStyle: PaintingStyle.stroke,
                          color: borderColor!,
                          isBorder: true)))),
      ],
    );
  }
}
