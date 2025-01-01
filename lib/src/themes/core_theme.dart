import 'package:flutter/material.dart';

/// Base theme class for diagram elements
class CoreTheme {
  /// Unique identifier for this theme
  final String id;

  /// Display name for this theme
  final String name;

  /// Color definitions for diagram elements
  final Map<String, Color> colors;

  const CoreTheme({
    required this.id,
    required this.name,
    required this.colors,
  });

  /// Creates a copy of this theme with some properties replaced
  CoreTheme copyWith({
    String? id,
    String? name,
    Map<String, Color>? colors,
  }) {
    return CoreTheme(
      id: id ?? this.id,
      name: name ?? this.name,
      colors: colors ?? Map.from(this.colors),
    );
  }

  /// Validates that all required colors are present
  bool validate() {
    const requiredColors = {
      'background',
      'grid',
      'gridMinor',
      'element',
    };
    return requiredColors.every(colors.containsKey);
  }
}
