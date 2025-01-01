import 'package:flutter/material.dart';
import '../renderer/diagram_renderer_base.dart';
import '../layer/diagram_layer.dart';
import '../state/diagram_state_manager.dart';
import '../coordinate/coordinate_system.dart';
import '../config/diagram_config.dart';

/// Abstract controller class that coordinates all diagram components
abstract class DiagramLayerController {
  late final DiagramRendererBase _renderer;
  late final IDiagramLayer _layer;
  late final CoordinateSystem _coordinates;
  late final DiagramStateManager _stateManager;
  DiagramConfig _config;

  DiagramLayerController({
    required DiagramConfig config,
  }) : _config = config;

  /// Initialize all core components
  @mustCallSuper
  void initializeComponents() {
    // Initialize components in dependency order
    _coordinates = createCoordinateSystem();
    
    _stateManager = createStateManager();
    
    _layer = createLayer();
    
    _renderer = createRenderer();
    
    // Initialize renderer with required dependencies
    _renderer.initialize(_layer, _coordinates);
    
    // Wire up component listeners
    _stateManager.addListener(onStateChanged);
    _layer.addListener(onElementsUpdated);
    
    // Force initial update
    updateDiagram();
  }

  /// Clean up resources
  @mustCallSuper
  void dispose() {
    _stateManager.removeListener(onStateChanged);
    _layer.removeListener(onElementsUpdated);
    _stateManager.dispose();
  }

  /// Update the diagram state and trigger a redraw
  void updateDiagram() {
    _stateManager.processUpdates();
    _layer.updateElements();
    _renderer.updateView();
  }

  /// Build the diagram widget
  Widget buildWidget() {
    return _renderer.buildDiagramWidget();
  }

  /// Connect the renderer to a state update callback
  void connectRenderer(VoidCallback onUpdate) {
    _renderer.setUpdateCallback(onUpdate);
  }

  /// Force a view refresh
  void invalidateView() {
    _renderer.updateView();
  }

  /// Protected access to core components
  @protected
  DiagramRendererBase get renderer => _renderer;
  
  @protected
  IDiagramLayer get layer => _layer;
  
  @protected
  CoordinateSystem get coordinates => _coordinates;
  
  @protected
  DiagramStateManager get stateManager => _stateManager;
  
  @protected
  DiagramConfig get config => _config;

  /// Factory methods for creating components - must be implemented by subclasses
  @protected
  DiagramRendererBase createRenderer();
  
  @protected
  IDiagramLayer createLayer();
  
  @protected
  CoordinateSystem createCoordinateSystem();
  
  @protected
  DiagramStateManager createStateManager();

  /// Event handlers for state changes and element updates
  @protected
  void onStateChanged() {
    layer.handleStateChange(stateManager.currentState);
    coordinates.updateTransform(stateManager.viewportState);
    invalidateView();
  }

  @protected
  void onElementsUpdated() {
    invalidateView();
  }

  /// Configuration updates
  @protected
  void updateConfig(DiagramConfig newConfig) {
    _config = newConfig;
    updateDiagram();
  }
}
