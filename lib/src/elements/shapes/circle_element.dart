import 'package:flutter/material.dart';
import '../drawable_element.dart';
import '../../coordinate/coordinate_system.dart';

/// A drawable circle element
class CircleElement extends DrawableElement {
  final double radius;

  CircleElement({
    required super.x,
    required super.y,
    required super.color,
    required this.radius,
    super.opacity = 1.0,
    super.transform,
  });

  @override
  void paintElement(Canvas canvas, CoordinateSystem coordinates) {
    // To be implemented
  }

  @override
  Rect getBounds() {
    return Rect.fromCircle(center: Offset(x, y), radius: radius);
  }
}
