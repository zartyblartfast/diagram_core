import 'package:flutter/material.dart';
import '../coordinate/coordinate_system.dart';
import 'drawable_element.dart';

/// Configuration for grid line appearance
class GridLineStyle {
  final Color color;
  final double strokeWidth;
  final List<double>? dashPattern;

  const GridLineStyle({
    required this.color,
    this.strokeWidth = 1.0,
    this.dashPattern,
  });
}

/// A drawable grid element with major and minor lines
class GridElement extends DrawableElement {
  /// The spacing between major grid lines
  final double majorSpacing;
  
  /// The spacing between minor grid lines
  final double minorSpacing;
  
  /// Style for major grid lines
  final GridLineStyle majorStyle;
  
  /// Style for minor grid lines
  final GridLineStyle minorStyle;
  
  /// Whether to show minor grid lines
  final bool showMinorLines;

  /// The coordinate system for this grid
  final CoordinateSystem coordinates;

  GridElement({
    super.x = 0,
    super.y = 0,
    required super.color,
    super.opacity = 1.0,
    super.transform,
    required this.majorSpacing,
    required this.minorSpacing,
    required this.coordinates,
    GridLineStyle? majorStyle,
    GridLineStyle? minorStyle,
    this.showMinorLines = true,
  }) : majorStyle = majorStyle ?? GridLineStyle(
         color: color,
         strokeWidth: 2.0,
       ),
       minorStyle = minorStyle ?? GridLineStyle(
         color: color.withOpacity(0.7),
         strokeWidth: 1.0,
       );

  @override
  void paintElement(Canvas canvas, CoordinateSystem coordinates) {
    if (showMinorLines) {
      _drawGridLines(canvas, coordinates, minorSpacing, minorStyle);
    }
    _drawGridLines(canvas, coordinates, majorSpacing, majorStyle);
  }

  void _drawGridLines(Canvas canvas, CoordinateSystem coordinates, double spacing, GridLineStyle style) {
    final paint = Paint()
      ..color = style.color.withOpacity(opacity)
      ..strokeWidth = style.strokeWidth
      ..style = PaintingStyle.stroke;

    print('Drawing grid lines with spacing: $spacing');
    print('Coordinate range: X(${coordinates.xRangeMin}, ${coordinates.xRangeMax}), Y(${coordinates.yRangeMin}, ${coordinates.yRangeMax})');
    print('Paint color: ${paint.color}, strokeWidth: ${paint.strokeWidth}');

    // Calculate the number of lines needed
    final xStart = (coordinates.xRangeMin / spacing).floor() * spacing;
    final xEnd = (coordinates.xRangeMax / spacing).ceil() * spacing;
    final yStart = (coordinates.yRangeMin / spacing).floor() * spacing;
    final yEnd = (coordinates.yRangeMax / spacing).ceil() * spacing;

    // Draw vertical lines
    for (double x = xStart; x <= xEnd; x += spacing) {
      final start = coordinates.toCanvas(x, coordinates.yRangeMin);
      final end = coordinates.toCanvas(x, coordinates.yRangeMax);
      canvas.drawLine(Offset(start.dx.roundToDouble(), start.dy), Offset(end.dx.roundToDouble(), end.dy), paint);
      print('Drawing vertical line at x=$x, start=$start, end=$end');
    }

    // Draw horizontal lines
    for (double y = yStart; y <= yEnd; y += spacing) {
      final start = coordinates.toCanvas(coordinates.xRangeMin, y);
      final end = coordinates.toCanvas(coordinates.xRangeMax, y);
      canvas.drawLine(Offset(start.dx, start.dy.roundToDouble()), Offset(end.dx, end.dy.roundToDouble()), paint);
      print('Drawing horizontal line at y=$y, start=$start, end=$end');
    }
  }

  @override
  Rect getBounds() {
    // Grid covers entire diagram area
    return Rect.fromLTWH(
      coordinates.xRangeMin,
      coordinates.yRangeMin,
      coordinates.xRangeMax - coordinates.xRangeMin,
      coordinates.yRangeMax - coordinates.yRangeMin
    );
  }
}
