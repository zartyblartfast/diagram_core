import 'package:flutter/material.dart';
import 'diagram_layer_controller.dart';
import '../renderer/diagram_renderer_base.dart';
import '../renderer/custom_paint_renderer.dart';
import '../layer/diagram_layer.dart';
import '../state/diagram_state_manager.dart';
import '../coordinate/coordinate_system.dart';
import '../config/diagram_config.dart';
import '../elements/drawable_element.dart';

/// Base class for diagrams that provides core functionality
abstract class CoreDiagramBase extends DiagramLayerController {
  /// Core visibility flags
  bool _showAxes = false;
  bool _showGrid = false;
  bool _showFrame = false;

  CoreDiagramBase({
    required DiagramConfig config,
  }) : _showAxes = config.showAxes,
       _showGrid = config.showGrid,
       _showFrame = config.showFrame,
       super(config: config);

  @override
  @protected
  CoordinateSystem createCoordinateSystem() {
    // Initialize with diagram ranges from config and canvas center origin
    final halfWidth = config.width / 2;
    final halfHeight = config.height / 2;
    
    return CoordinateSystem(
      origin: Offset(halfWidth, halfHeight),  // Start at canvas center
      xRangeMin: config.xRangeMin,
      xRangeMax: config.xRangeMax,
      yRangeMin: config.yRangeMin,
      yRangeMax: config.yRangeMax,
      canvasSize: Size(config.width, config.height),  // Pass canvas size
    );
  }

  @override
  @protected
  IDiagramLayer createLayer() {
    print('Creating layer...');
    final newLayer = BasicDiagramLayer(
      coordinateSystem: coordinates,
      showAxes: _showAxes,
    );
    
    // Add initial elements
    print('Adding elements to layer...');
    final elements = createDiagramElements();
    print('Created ${elements.length} elements');
    for (final element in elements) {
      print('  Adding element: ${element.runtimeType}');
      newLayer.addElement(element);
    }
    
    return newLayer;
  }

  /// Update layer elements
  void updateElements() {
    print('Updating elements...');
    layer.clear();
    final elements = createDiagramElements();
    print('Created ${elements.length} elements');
    for (final element in elements) {
      print('  Adding element: ${element.runtimeType}');
      layer.addElement(element);
    }
    updateDiagram();
  }

  @override
  @protected
  DiagramStateManager createStateManager() {
    return DiagramStateManager();
  }

  @override
  @protected
  DiagramRendererBase createRenderer() {
    // Default to CustomPaintRenderer, can be overridden by derived classes
    return CustomPaintRenderer(config: config);
  }

  /// Create diagram-specific elements
  @protected
  List<DrawableElement> createDiagramElements();

  /// Toggle axes visibility
  void toggleAxes() {
    _showAxes = !_showAxes;
    updateElements();
  }

  /// Toggle grid visibility
  void toggleGrid() {
    _showGrid = !_showGrid;
    updateElements();
  }

  /// Toggle frame visibility
  void toggleFrame() {
    _showFrame = !_showFrame;
    updateElements();
  }

  /// Update element visibility by key
  void updateVisibility(String key, bool isVisible) {
    switch (key) {
      case 'grid':
        _showGrid = isVisible;
        break;
      case 'axes':
        _showAxes = isVisible;
        break;
      case 'frame':
        _showFrame = isVisible;
        break;
    }
    updateElements();
  }

  // Getters for visibility flags
  bool get showAxes => _showAxes;
  bool get showGrid => _showGrid;
  bool get showFrame => _showFrame;

  // Getters for core properties from config
  double get canvasWidth => config.width;
  double get canvasHeight => config.height;
  double get xRangeMin => config.xRangeMin;
  double get xRangeMax => config.xRangeMax;
  double get yRangeMin => config.yRangeMin;
  double get yRangeMax => config.yRangeMax;
}
