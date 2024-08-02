import 'dart:math';

import 'package:flutter/material.dart';

// Distance along line for when to set quadratic bezier start point, e.g.
//      A value of 0.2 means that the first quadratic bezier curve will start at a point 20% from
//      from the line beginning, and the second quadratic bezier curve will start at a point 80% from
//      the line beginning (20% from the line end)
// This keeps the curves consistent on each side of the triangle
const distanceFactor = 0.2;

// Default value for border width -  is percentage of canvas size for consistency
const defaultBorderFactor = 0.05;

/// Paints a triangle with rounded edges. [isBorder] dictates whether [paintingStyle] is fill or stroke,
/// given [color] is applied respectively
class TrianglePainter extends CustomPainter {
  final PaintingStyle paintingStyle;
  final Color color;
  final bool isBorder;

  TrianglePainter({required this.paintingStyle, required this.color, this.isBorder = false});

  @override
  void paint(Canvas canvas, Size size) {
    // Parent class uses same value for size and width
    final canvasSize = size.width;

    // Set up painter
    Paint paint = Paint()
      ..color = color
      ..strokeWidth = isBorder ? canvasSize * defaultBorderFactor : 0
      ..style = paintingStyle;

    // Anchor points for quadratic bezier with reduced height to center widget
    Point p1 = Point(canvasSize / 2, 0);
    Point p2 = Point(0, canvasSize * 0.9);
    Point p3 = Point(canvasSize, canvasSize * 0.9);

    // Start/end points for quadratic bezier
    // p1 - p2
    Point p1p2Start = getLinePoint(p1, p2, closeToStart: true);
    Point p1p2End = getLinePoint(p1, p2, closeToStart: false);
    // p2 - p3
    Point p2p3Start = getLinePoint(p2, p3, closeToStart: true);
    Point p2p3End = getLinePoint(p2, p3, closeToStart: false);

    // p3 - p1
    Point p3p1Start = getLinePoint(p3, p1, closeToStart: true);
    Point p3p1End = getLinePoint(p3, p1, closeToStart: false);
    canvas.drawPath(
        Path()
          // Move to point at top left
          ..moveTo(p1p2Start.x.toDouble(), p1p2Start.y.toDouble())
          // Draw line from top left to bottom left
          ..lineTo(p1p2End.x.toDouble(), p1p2End.y.toDouble())
          // Draw curve from bottom left towards bottom right
          ..quadraticBezierTo(
              p2.x.toDouble(), p2.y.toDouble(), p2p3Start.x.toDouble(), p2p3Start.y.toDouble())
          // Draw line to bottom right
          ..lineTo(p2p3End.x.toDouble(), p2p3End.y.toDouble())
          // Draw curve from bottom right towards top
          ..quadraticBezierTo(
              p3.x.toDouble(), p3.y.toDouble(), p3p1Start.x.toDouble(), p3p1Start.y.toDouble())
          // Draw line to top
          ..lineTo(p3p1End.x.toDouble(), p3p1End.y.toDouble())
          // Draw curve from top towards bottom left
          ..quadraticBezierTo(
              p1.x.toDouble(), p1.y.toDouble(), p1p2Start.x.toDouble(), p1p2Start.y.toDouble()),
        paint);
  }

  /// Returns a [Point] on a line given [start] and [end] points
  /// [closeToStart] dictates if the point returned will be closer to [start] (true) or [end] (false)
  Point getLinePoint(Point start, Point end, {required bool closeToStart}) {
    int x = (start.x * (1 - distanceFactor) + end.x * distanceFactor).round();
    int y = (start.y * (1 - distanceFactor) + end.y * distanceFactor).round();

    return Point(x, y);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
