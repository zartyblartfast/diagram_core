import 'package:flutter/material.dart';
import '../coordinate/coordinate_system.dart';
import 'drawable_element.dart';

/// Configuration for axis appearance
class AxisStyle {
  final Color color;
  final double strokeWidth;
  final TextStyle labelStyle;
  final double tickLength;
  final double tickLabelGap;

  const AxisStyle({
    required this.color,
    this.strokeWidth = 1.0,
    required this.labelStyle,
    this.tickLength = 0.2,  // Changed to 0.2 diagram units
    this.tickLabelGap = 0.1,  // Changed to 0.1 diagram units
  });
}

/// Represents the orientation of an axis
enum AxisOrientation {
  horizontal,
  vertical
}

/// A drawable axis element with ticks and labels
class AxisElement extends DrawableElement {
  /// The orientation of this axis
  final AxisOrientation orientation;
  
  /// The interval between major ticks
  final double majorTickInterval;
  
  /// The interval between minor ticks (if enabled)
  final double? minorTickInterval;
  
  /// Custom formatting function for tick labels
  final String Function(double value) labelFormatter;
  
  /// Style configuration for the axis
  final AxisStyle style;
  
  /// Whether to show tick labels
  final bool showLabels;
  
  /// Whether to show minor ticks
  final bool showMinorTicks;

  AxisElement({
    required super.x,
    required super.y,
    required super.color,
    super.opacity = 1.0,
    super.transform,
    required this.orientation,
    required this.majorTickInterval,
    this.minorTickInterval,
    String Function(double)? labelFormatter,
    AxisStyle? style,
    this.showLabels = true,
    this.showMinorTicks = true,
  }) : style = style ?? AxisStyle(
         color: color,
         strokeWidth: 2.0,  // Increased stroke width
         labelStyle: TextStyle(
           color: color,
           fontSize: 14,  // Increased font size
         ),
         tickLength: 8.0,  // Increased tick length
       ),
       labelFormatter = labelFormatter ?? ((value) => value.toInt().toString());

  @override
  void paintElement(Canvas canvas, CoordinateSystem coordinates) {
    if (orientation == AxisOrientation.horizontal) {
      _paintHorizontalAxis(canvas, coordinates);
    } else {
      _paintVerticalAxis(canvas, coordinates);
    }
  }

  void _paintHorizontalAxis(Canvas canvas, CoordinateSystem coordinates) {
    final paint = Paint()
      ..color = color.withOpacity(opacity)
      ..strokeWidth = style.strokeWidth
      ..style = PaintingStyle.stroke;

    final start = coordinates.toCanvas(coordinates.xRangeMin, y);
    final end = coordinates.toCanvas(coordinates.xRangeMax, y);
    canvas.drawLine(start, end, paint);

    final ticks = _generateTickPositions(coordinates.xRangeMin, coordinates.xRangeMax, majorTickInterval);

    for (final tickX in ticks) {
      final tickStart = coordinates.toCanvas(tickX, y);
      final tickEnd = coordinates.toCanvas(tickX, y + style.tickLength);
      canvas.drawLine(tickStart, tickEnd, paint);

      if (showLabels) {
        final label = labelFormatter(tickX);
        final textPainter = TextPainter(
          text: TextSpan(
            text: label,
            style: style.labelStyle,
          ),
          textDirection: TextDirection.ltr,
        );
        textPainter.layout();
        final labelPosition = coordinates.toCanvas(tickX, y + style.tickLength + style.tickLabelGap);
        textPainter.paint(canvas, labelPosition - Offset(textPainter.width / 2, textPainter.height));
      }
    }

    if (showMinorTicks && minorTickInterval != null) {
      final minorTicks = _generateTickPositions(coordinates.xRangeMin, coordinates.xRangeMax, minorTickInterval!)
        ..removeWhere((x) => ticks.contains(x));

      final minorTickPaint = Paint()
        ..color = style.color.withOpacity(opacity * 0.7)
        ..strokeWidth = paint.strokeWidth * 0.5
        ..style = PaintingStyle.stroke;

      for (final tickX in minorTicks) {
        final tickStart = coordinates.toCanvas(tickX, y);
        final tickEnd = coordinates.toCanvas(tickX, y + style.tickLength * 0.5);
        canvas.drawLine(tickStart, tickEnd, minorTickPaint);
      }
    }
  }

  void _paintVerticalAxis(Canvas canvas, CoordinateSystem coordinates) {
    final paint = Paint()
      ..color = color.withOpacity(opacity)
      ..strokeWidth = style.strokeWidth
      ..style = PaintingStyle.stroke;

    final start = coordinates.toCanvas(x, coordinates.yRangeMin);
    final end = coordinates.toCanvas(x, coordinates.yRangeMax);
    canvas.drawLine(start, end, paint);

    final ticks = _generateTickPositions(coordinates.yRangeMin, coordinates.yRangeMax, majorTickInterval);

    for (final tickY in ticks) {
      final tickStart = coordinates.toCanvas(x, tickY);
      final tickEnd = coordinates.toCanvas(x - style.tickLength, tickY);
      canvas.drawLine(tickStart, tickEnd, paint);

      if (showLabels) {
        final label = labelFormatter(tickY);
        final textPainter = TextPainter(
          text: TextSpan(
            text: label,
            style: style.labelStyle,
          ),
          textDirection: TextDirection.ltr,
        );
        textPainter.layout();
        final labelPosition = coordinates.toCanvas(x - style.tickLength - style.tickLabelGap, tickY);
        textPainter.paint(canvas, labelPosition - Offset(textPainter.width, textPainter.height / 2));
      }
    }

    if (showMinorTicks && minorTickInterval != null) {
      final minorTicks = _generateTickPositions(coordinates.yRangeMin, coordinates.yRangeMax, minorTickInterval!)
        ..removeWhere((y) => ticks.contains(y));

      final minorTickPaint = Paint()
        ..color = style.color.withOpacity(opacity * 0.7)
        ..strokeWidth = paint.strokeWidth * 0.5
        ..style = PaintingStyle.stroke;

      for (final tickY in minorTicks) {
        final tickStart = coordinates.toCanvas(x, tickY);
        final tickEnd = coordinates.toCanvas(x - style.tickLength * 0.5, tickY);
        canvas.drawLine(tickStart, tickEnd, minorTickPaint);
      }
    }
  }

  @override
  Rect getBounds() {
    // Return a minimal bounding box since actual bounds depend on coordinate system
    if (orientation == AxisOrientation.horizontal) {
      final height = (style.tickLength + (showLabels ? style.tickLabelGap + 20.0 : 0.0));
      return Rect.fromLTWH(x, y - height, 1.0, height);
    } else {
      final width = (style.tickLength + (showLabels ? style.tickLabelGap + 40.0 : 0.0));
      return Rect.fromLTWH(x - width, y, width, 1.0);
    }
  }

  /// Generates tick positions within the given range and interval
  List<double> _generateTickPositions(double start, double end, double interval) {
    final positions = <double>[];
    var pos = (start / interval).floor() * interval;
    
    while (pos <= end) {
      if (pos >= start) {
        positions.add(pos);
      }
      pos += interval;
    }
    
    return positions;
  }
}
