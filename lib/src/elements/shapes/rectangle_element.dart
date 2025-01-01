import 'package:flutter/material.dart';
import '../../coordinate/coordinate_system.dart';
import '../drawable_element.dart';

/// A rectangle element that is centered by default.
/// Used for creating rectangles in diagrams.
class RectangleElement extends DrawableElement {
  /// Width of the rectangle
  final double width;
  
  /// Height of the rectangle
  final double height;
  
  /// Width of the border stroke
  final double strokeWidth;
  
  /// Fill color for the rectangle
  final Color? fillColor;
  
  /// Opacity of the fill (0.0 to 1.0)
  final double fillOpacity;
  
  /// Radius for rounded corners
  final double? borderRadius;

  /// Creates a centered rectangle element.
  /// 
  /// The [x] and [y] coordinates specify the center point.
  /// [color] is used for the border stroke.
  /// [fillColor] is optional - if provided, fills the rectangle.
  /// [fillOpacity] controls fill transparency (0.0 to 1.0).
  /// [borderRadius] is optional - if provided, rounds the corners.
  RectangleElement({
    required double x,
    required double y,
    required this.width,
    required this.height,
    required Color color,
    this.strokeWidth = 1.0,
    this.fillColor,
    this.fillOpacity = 1.0,
    this.borderRadius,
  }) : assert(fillOpacity >= 0.0 && fillOpacity <= 1.0),
       assert(borderRadius == null || borderRadius >= 0.0),
       super(x: x, y: y, color: color);

  @override
  void paintElement(Canvas canvas, CoordinateSystem coordinates) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    // Convert center point to canvas coordinates
    final center = coordinates.toCanvas(x, y);
    
    // Calculate rectangle bounds from center point
    final rect = Rect.fromCenter(
      center: center,
      width: width * coordinates.scale,
      height: height * coordinates.scale,
    );

    // Draw fill if fillColor is provided
    if (fillColor != null) {
      final fillPaint = Paint()
        ..color = fillColor!.withOpacity(fillOpacity)
        ..style = PaintingStyle.fill;
      
      if (borderRadius != null) {
        canvas.drawRRect(
          RRect.fromRectXY(rect, borderRadius!, borderRadius!),
          fillPaint,
        );
      } else {
        canvas.drawRect(rect, fillPaint);
      }
    }
    
    // Draw border
    if (borderRadius != null) {
      canvas.drawRRect(
        RRect.fromRectXY(rect, borderRadius!, borderRadius!),
        paint,
      );
    } else {
      canvas.drawRect(rect, paint);
    }
  }

  @override
  Rect getBounds() {
    // Return bounds in diagram coordinates (before coordinate system transformation)
    return Rect.fromCenter(
      center: Offset(x, y),
      width: width,
      height: height,
    );
  }
}
