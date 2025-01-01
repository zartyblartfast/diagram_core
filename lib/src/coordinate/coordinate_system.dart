import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart';
import 'dart:math' as math;

/// Handles coordinate transformations between diagram and canvas space
class CoordinateSystem {
  final Offset origin;
  final double xRangeMin;
  final double xRangeMax;
  final double yRangeMin;
  final double yRangeMax;
  double scale;
  final Size canvasSize;

  /// View transformation matrix
  late Matrix4 _transform;
  late Matrix4 _inverseTransform;

  CoordinateSystem({
    required this.origin,
    required this.xRangeMin,
    required this.xRangeMax,
    required this.yRangeMin,
    required this.yRangeMax,
    required this.canvasSize,
    this.scale = 1.0,
  }) {
    _updateTransform();
  }

  /// Updates the transformation matrices based on current settings
  void _updateTransform() {
    // Calculate scaling factors to fit diagram range to canvas size
    final xScale = canvasSize.width / (xRangeMax - xRangeMin);
    final yScale = canvasSize.height / (yRangeMax - yRangeMin);
    scale = xScale < yScale ? xScale : yScale;
    
    // Transform sequence:
    // 1. Move diagram coordinates to origin
    // 2. Scale to fit canvas
    // 3. Flip Y axis
    // 4. Move to canvas position
    final centerX = (xRangeMax + xRangeMin) / 2;
    final centerY = (yRangeMax + yRangeMin) / 2;
    
    _transform = Matrix4.identity()
      ..translate(-centerX, -centerY)  // Center diagram at origin
      ..scale(scale, scale)           // Scale to fit canvas
      ..scale(1.0, -1.0)             // Flip Y axis
      ..translate(origin.dx, origin.dy); // Move to canvas position

    // Create inverse transform in reverse order
    _inverseTransform = Matrix4.identity()
      ..translate(-origin.dx, -origin.dy)
      ..scale(1.0, -1.0)
      ..scale(1/scale, 1/scale)
      ..translate(centerX, centerY);
  }

  /// Updates the transform based on viewport state
  void updateTransform(Map<String, dynamic> viewportState) {
    // Implementation will depend on what viewport state contains
    // For now, just re-calculate the transform
    _updateTransform();
  }

  /// Converts diagram coordinates to canvas coordinates
  Offset toCanvas(double x, double y) {
    final canvasX = (x - xRangeMin) / (xRangeMax - xRangeMin) * canvasSize.width;
    final canvasY = (yRangeMax - y) / (yRangeMax - yRangeMin) * canvasSize.height;
    return Offset(canvasX, canvasY);
  }

  /// Converts canvas coordinates to diagram coordinates
  Offset fromCanvas(double x, double y) {
    final diagramX = x / canvasSize.width * (xRangeMax - xRangeMin) + xRangeMin;
    final diagramY = yRangeMax - y / canvasSize.height * (yRangeMax - yRangeMin);
    return Offset(diagramX, diagramY);
  }

  /// Updates the scale based on the canvas size and coordinate range
  void updateScale() {
    final xScale = canvasSize.width / (xRangeMax - xRangeMin);
    final yScale = canvasSize.height / (yRangeMax - yRangeMin);
    scale = math.min(xScale, yScale);
  }

  /// Gets the width of the diagram space in diagram units
  double get width => xRangeMax - xRangeMin;

  /// Gets the height of the diagram space in diagram units
  double get height => yRangeMax - yRangeMin;

  /// Creates a copy with updated parameters
  CoordinateSystem copyWith({
    Offset? origin,
    double? xRangeMin,
    double? xRangeMax,
    double? yRangeMin,
    double? yRangeMax,
    Size? canvasSize,
    double? scale,
  }) {
    return CoordinateSystem(
      origin: origin ?? this.origin,
      xRangeMin: xRangeMin ?? this.xRangeMin,
      xRangeMax: xRangeMax ?? this.xRangeMax,
      yRangeMin: yRangeMin ?? this.yRangeMin,
      yRangeMax: yRangeMax ?? this.yRangeMax,
      canvasSize: canvasSize ?? this.canvasSize,
      scale: scale ?? this.scale,
    );
  }
}
