import 'package:flutter/material.dart';
import '../coordinate/coordinate_system.dart';
import '../coordinate/canvas_alignment.dart';
import '../layer/diagram_layer.dart';
import '../config/diagram_config.dart';

/// Base class for diagram renderers
abstract class DiagramRendererBase {
  final DiagramConfig config;
  late final IDiagramLayer _layer;
  late CoordinateSystem _coordinates;  // Remove final to allow updating

  DiagramRendererBase({
    required this.config,
  });

  /// Initialize the renderer with layer and coordinate system
  void initialize(IDiagramLayer layer, CoordinateSystem coordinates) {
    _layer = layer;
    _coordinates = coordinates;
  }

  /// Build the widget that will display the diagram
  Widget buildDiagramWidget();

  /// Update callback for triggering rebuilds
  VoidCallback? _updateCallback;

  /// Set the update callback
  void setUpdateCallback(VoidCallback callback) {
    _updateCallback = callback;
  }

  /// Update the view (trigger a rebuild)
  void updateView() {
    _updateCallback?.call();
  }

  /// Paint the diagram on a canvas
  void paint(Canvas canvas, Size size) {
    print('Painting diagram...');
    print('Canvas size: $size');
    
    // Save canvas state
    canvas.save();
    
    // Update coordinate system with new canvas size
    _coordinates = _coordinates.copyWith(canvasSize: size);
    _coordinates.updateScale();
    
    // Paint all elements in the layer using the updated coordinate system
    print('Painting elements...');
    for (final element in _layer.elements) {
      print('  Painting element: ${element.runtimeType}');
      print('    Coordinate scale: ${_coordinates.scale}');
      canvas.save();
      element.paint(canvas, _coordinates);
      canvas.restore();
    }
    
    // Restore canvas state
    canvas.restore();
  }

  /// Apply any global canvas transformations needed
  @protected
  void _applyCanvasTransform(Canvas canvas, Size size) {
    // Default implementation does nothing
    // Derived classes can override to apply specific transformations
  }

  /// Get the current layer
  @protected
  IDiagramLayer get layer => _layer;

  /// Get the coordinate system
  @protected
  CoordinateSystem get coordinates => _coordinates;
}
