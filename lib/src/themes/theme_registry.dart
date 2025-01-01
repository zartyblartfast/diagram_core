import 'package:flutter/material.dart';
import 'core_theme.dart';
import 'built_in/monochrome_theme.dart';

/// Manages theme registration and selection
class ThemeRegistry {
  static final ThemeRegistry instance = ThemeRegistry._();
  
  ThemeRegistry._() {
    // Register default themes
    registerTheme(MonochromeTheme());
    registerTheme(DarkMonochromeTheme());
  }

  final Map<String, CoreTheme> _themes = {};
  String _currentThemeId = MonochromeTheme.themeId;

  /// Get the current theme
  CoreTheme get currentTheme => _themes[_currentThemeId]!;

  /// Register a new theme
  void registerTheme(CoreTheme theme) {
    assert(theme.validate(), 'Theme ${theme.name} is missing required colors');
    _themes[theme.id] = theme;
  }

  /// Toggle to the next available theme
  void toggleTheme() {
    var themeIds = _themes.keys.toList();
    var currentIndex = themeIds.indexOf(_currentThemeId);
    _currentThemeId = themeIds[(currentIndex + 1) % themeIds.length];
  }

  /// Set a specific theme by ID
  void setTheme(String themeId) {
    assert(_themes.containsKey(themeId), 'Theme $themeId not found');
    _currentThemeId = themeId;
  }

  /// Get all available themes
  List<CoreTheme> get availableThemes => _themes.values.toList();
}
