import 'package:flutter/material.dart';
import '../coordinate/coordinate_system.dart';

/// Base class for all drawable elements in a diagram
abstract class DrawableElement {
  /// Element position in diagram coordinates
  double x;
  double y;
  
  /// Element style properties
  Color color;
  double opacity;
  
  /// Optional transformation matrix
  Matrix4? transform;
  
  DrawableElement({
    required this.x,
    required this.y,
    required this.color,
    this.opacity = 1.0,
    this.transform,
  });

  /// Paint the element on the canvas
  void paint(Canvas canvas, CoordinateSystem coordinates) {
    // Save canvas state
    canvas.save();
    
    // Apply element transform if any
    if (transform != null) {
      canvas.transform(transform!.storage);
    }
    
    // Paint the element
    paintElement(canvas, coordinates);
    
    // Restore canvas state
    canvas.restore();
  }

  /// Paint the element's content
  /// This method should be implemented by derived classes
  @protected
  void paintElement(Canvas canvas, CoordinateSystem coordinates);

  /// Get the bounds of the element in diagram coordinates
  Rect getBounds();

  /// Update the element's state
  void update(Map<String, dynamic> state) {
    // Base implementation does nothing
    // Derived classes can override to handle specific state updates
  }

  /// Convert diagram coordinates to canvas coordinates
  Offset toCanvas(CoordinateSystem coordinates, double x, double y) {
    return coordinates.toCanvas(x, y);
  }

  /// Convert canvas coordinates to diagram coordinates
  Offset fromCanvas(CoordinateSystem coordinates, double x, double y) {
    return coordinates.fromCanvas(x, y);
  }

  /// Helper to set up paint with current style
  Paint get defaultPaint => Paint()
    ..color = color.withOpacity(opacity)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1.0;
}
