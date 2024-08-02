library rounded_triangle;

import 'package:flutter/material.dart';
import 'package:rounded_triangle/triangle_painter.dart';

const Color defaultFillColor = Colors.white;
const Color defaultBorderColor = Colors.black;
const double defaultIconSize = 48;

/// Create a customised-rounded triangle
///
/// [fillColor] (Optional) Fill color for inside of triangle, defaults to [defaultFillColor]
/// [borderColor] (Optional) Border color for edges of triangle, defaults to [defaultBorderColor]
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
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        // Base triangle shape
        SizedBox(
          height: iconSize,
          width: iconSize,
          child: SizedBox(
              height: iconSize,
              width: iconSize,
              child: CustomPaint(
                  painter: TrianglePainter(paintingStyle: PaintingStyle.fill, color: fillColor!))),
        ),
        // Draw border if color or thickness has been set
        if (borderColor != null)
          SizedBox(
              height: iconSize,
              width: iconSize,
              child: SizedBox(
                  height: iconSize,
                  width: iconSize,
                  child: CustomPaint(
                      painter: TrianglePainter(
                          paintingStyle: PaintingStyle.stroke,
                          color: borderColor ?? defaultBorderColor,
                          isBorder: true)))),
      ],
    );
  }
}
