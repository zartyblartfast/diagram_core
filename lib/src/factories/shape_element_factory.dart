import 'package:flutter/material.dart';
import '../elements/shapes/rectangle_element.dart';
import 'element_factory.dart';

/// Factory for creating shape elements like rectangles, circles, etc.
/// All shapes are center-referenced by default.
class ShapeElementFactory extends ElementFactory {
  const ShapeElementFactory({required super.config});

  /// Creates a centered rectangle element.
  /// 
  /// [centerX] and [centerY] specify the center point.
  /// [width] and [height] specify dimensions.
  /// [color] is used for the border stroke.
  /// [fillColor] is optional - if provided, fills the rectangle.
  /// [strokeWidth] sets border thickness (default: 1.0).
  /// [fillOpacity] controls fill transparency (default: 1.0).
  /// [borderRadius] is optional - if provided, rounds the corners.
  RectangleElement createRectangle({
    required double centerX,
    required double centerY,
    required double width,
    required double height,
    required Color color,
    Color? fillColor,
    double strokeWidth = 1.0,
    double fillOpacity = 1.0,
    double? borderRadius,
  }) {
    return RectangleElement(
      x: centerX,
      y: centerY,
      width: width,
      height: height,
      color: color,
      fillColor: fillColor,
      strokeWidth: strokeWidth,
      fillOpacity: fillOpacity,
      borderRadius: borderRadius,
    );
  }
}
