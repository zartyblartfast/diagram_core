import 'package:flutter/material.dart';
import 'coordinate_system.dart';

/// Manages the alignment and scaling of a CoordinateSystem relative to a canvas.
///
/// This class is responsible for:
/// * Calculating and applying the appropriate scale factor based on canvas dimensions
/// * Positioning the coordinate system origin relative to the canvas
/// * Ensuring atomic updates of both scale and origin
class CanvasAlignment {
  /// The size of the canvas being rendered to
  final Size canvasSize;
  
  /// The coordinate system to align
  CoordinateSystem coordinateSystem;

  /// Creates a new canvas alignment handler
  CanvasAlignment({
    required this.canvasSize,
    required this.coordinateSystem,
  });

  /// Updates the scale of the coordinate system based on canvas size and coordinate range
  void updateScale() {
    // Calculate the total range in each dimension
    final xRange = coordinateSystem.xRangeMax - coordinateSystem.xRangeMin;
    final yRange = coordinateSystem.yRangeMax - coordinateSystem.yRangeMin;
    
    // Calculate scale factors to fit the ranges in the canvas
    // Leave some padding (0.9) to ensure content isn't right at the edges
    final xScale = (canvasSize.width * 0.9) / xRange;
    final yScale = (canvasSize.height * 0.9) / yRange;
    
    // Use the smaller scale to maintain aspect ratio
    final newScale = xScale < yScale ? xScale : yScale;
    
    print('Canvas size: $canvasSize');
    print('X range: $xRange, Y range: $yRange');
    print('X scale: $xScale, Y scale: $yScale');
    print('New scale: $newScale');
    
    // Update coordinate system with new scale
    coordinateSystem = coordinateSystem.copyWith(
      scale: newScale,  // Use raw scale, let elements handle their own stroke widths
    );
  }

  /// Aligns the CoordinateSystem.origin to the center of the canvas
  void alignCenter() {
    // Calculate the scale first to ensure proper sizing
    updateScale();
    
    // For center alignment, diagram (0,0) should map to canvas center
    final center = Offset(
      canvasSize.width / 2,
      canvasSize.height / 2,
    );
    
    print('Canvas center: $center');
    
    // Update coordinate system with new origin
    coordinateSystem = coordinateSystem.copyWith(
      origin: center,
    );
  }

  /// Aligns the CoordinateSystem.origin to the bottom center of the canvas
  void alignBottomCenter() {
    // Calculate the scale first to ensure proper sizing
    updateScale();
    
    // For bottom center alignment, diagram (0,0) should map to canvas bottom center
    final bottomCenter = Offset(
      canvasSize.width / 2,
      canvasSize.height,
    );
    
    // Update coordinate system with new origin
    coordinateSystem = coordinateSystem.copyWith(
      origin: bottomCenter,
    );
  }
}
