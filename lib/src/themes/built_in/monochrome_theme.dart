import 'package:flutter/material.dart';
import '../core_theme.dart';

/// Default monochrome theme implementation
class MonochromeTheme extends CoreTheme {
  static const String themeId = 'monochrome';

  MonochromeTheme()
      : super(
          id: themeId,
          name: 'Monochrome',
          colors: {
            'background': Colors.white,
            'element': Colors.black,
            'elementFill': Color(0x33448AFF),  // Light blue with opacity
            'grid': Color(0x8A000000),         // Colors.black54
            'gridMinor': Color(0x42000000),    // Colors.black26
          },
        );
}

/// Dark monochrome theme implementation
class DarkMonochromeTheme extends CoreTheme {
  static const String themeId = 'monochrome_dark';

  DarkMonochromeTheme()
      : super(
          id: themeId,
          name: 'Dark Monochrome',
          colors: {
            'background': Color(0xFF1E1E1E),
            'element': Colors.white,
            'elementFill': Color(0x4DFFFFFF),  // Colors.white30
            'grid': Color(0x8AFFFFFF),         // Colors.white54
            'gridMinor': Color(0x42FFFFFF),    // Colors.white26
          },
        );
}
