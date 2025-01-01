import 'package:flutter/foundation.dart';
import '../coordinate/coordinate_system.dart';
import '../elements/drawable_element.dart';

/// Interface defining the contract for diagram layers
abstract class IDiagramLayer extends ChangeNotifier {
  /// The coordinate system used by this layer
  CoordinateSystem get coordinateSystem;

  /// Updates the coordinate system
  void updateCoordinateSystem(CoordinateSystem newSystem);

  /// Adds an element to the layer
  void addElement(DrawableElement element);

  /// Updates all elements in the layer
  void updateElements();

  /// Handles state changes from the diagram controller
  void handleStateChange(Map<String, dynamic> state);

  /// Gets all elements in the layer
  List<DrawableElement> get elements;

  /// Clears all elements from the layer
  void clear();
}

/// Basic implementation of IDiagramLayer that maintains a list of drawable elements
class BasicDiagramLayer extends ChangeNotifier implements IDiagramLayer {
  CoordinateSystem _coordinateSystem;
  final List<DrawableElement> _elements = [];
  final bool showAxes;

  BasicDiagramLayer({
    required CoordinateSystem coordinateSystem,
    this.showAxes = true,
  }) : _coordinateSystem = coordinateSystem;

  @override
  CoordinateSystem get coordinateSystem => _coordinateSystem;

  @override
  void updateCoordinateSystem(CoordinateSystem newSystem) {
    _coordinateSystem = newSystem;
    notifyListeners();
  }

  @override
  void addElement(DrawableElement element) {
    _elements.add(element);
    notifyListeners();
  }

  @override
  void updateElements() {
    notifyListeners();
  }

  @override
  void handleStateChange(Map<String, dynamic> state) {
    updateElements();
  }

  @override
  List<DrawableElement> get elements => List.unmodifiable(_elements);

  @override
  void clear() {
    _elements.clear();
    notifyListeners();
  }
}
