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
    print('Updating coordinate system');
    print('Old origin: ${_coordinateSystem.origin}');
    print('New origin: ${newSystem.origin}');
    print('Old scale: ${_coordinateSystem.scale}');
    print('New scale: ${newSystem.scale}');
    _coordinateSystem = newSystem;
    notifyListeners();
  }

  @override
  void addElement(DrawableElement element) {
    print('Adding element: ${element.runtimeType}');
    _elements.add(element);
    notifyListeners();
  }

  @override
  void updateElements() {
    print('Updating elements');
    // Trigger a rebuild of all elements
    notifyListeners();
  }

  @override
  void handleStateChange(Map<String, dynamic> state) {
    print('Handling state change');
    // Basic implementation just triggers an update
    // Derived classes can implement more sophisticated state handling
    updateElements();
  }

  @override
  List<DrawableElement> get elements => List.unmodifiable(_elements);

  @override
  void clear() {
    print('Clearing elements');
    _elements.clear();
    notifyListeners();
  }
}
