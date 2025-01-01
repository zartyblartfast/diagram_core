import 'package:flutter/foundation.dart';

/// Manages state for a diagram
class DiagramStateManager extends ChangeNotifier {
  final Map<String, dynamic> _state = {};
  final Map<String, dynamic> _viewportState = {};
  bool _isDarkTheme = false;

  DiagramStateManager();

  /// Get a value from the state
  T? getValue<T>(String key) {
    return _state[key] as T?;
  }

  /// Update a value in the state
  void updateValue<T>(String key, T value) {
    _state[key] = value;
    notifyListeners();
  }

  /// Update multiple values at once
  void updateValues(Map<String, dynamic> updates) {
    _state.addAll(updates);
    notifyListeners();
  }

  /// Get the current theme state
  bool get isDarkTheme => _isDarkTheme;

  /// Toggle between light and dark themes
  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  /// Get the current viewport state
  Map<String, dynamic> get viewportState => Map.unmodifiable(_viewportState);

  /// Update viewport state
  void updateViewport(Map<String, dynamic> updates) {
    _viewportState.addAll(updates);
    notifyListeners();
  }

  /// Get the complete current state
  Map<String, dynamic> get currentState => Map.unmodifiable(_state);

  /// Process any pending state updates
  void processUpdates() {
    // Default implementation just notifies listeners
    // Derived classes can implement more sophisticated update processing
    notifyListeners();
  }

  @override
  void dispose() {
    _state.clear();
    _viewportState.clear();
    super.dispose();
  }
}
