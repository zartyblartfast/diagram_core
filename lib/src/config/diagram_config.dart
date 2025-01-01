import 'package:flutter/material.dart';

/// Configuration class for diagram settings
class DiagramConfig {
  // Canvas dimensions
  final double width;
  final double height;
  
  // Coordinate system ranges
  final double xRangeMin;
  final double xRangeMax;
  final double yRangeMin;
  final double yRangeMax;
  
  // Grid settings
  final Color gridMajorColor;
  final Color gridMinorColor;
  final double gridMajorOpacity;
  final double gridMinorOpacity;
  final double gridMajorSpacing;
  final double gridMinorSpacing;
  
  // Axis settings
  final Color axisColor;
  final double axisOpacity;
  final double axisTickInterval;
  final String axisLabelFormat;  // 'integer' (default) or 'decimal'
  
  // Frame settings
  final Color frameStrokeColor;
  final double frameStrokeWidth;
  final double frameStrokeOpacity;
  final bool frameFill;
  final Color frameFillColor;
  final double frameFillOpacity;
  
  // Visibility flags
  final bool showAxes;
  final bool showGrid;
  final bool showFrame;

  const DiagramConfig({
    this.width = 300,  // Square canvas
    this.height = 300, // Square canvas
    this.xRangeMin = -10,
    this.xRangeMax = 10,
    this.yRangeMin = -10,
    this.yRangeMax = 10,
    this.gridMajorColor = Colors.grey,
    this.gridMinorColor = Colors.grey,
    this.gridMajorOpacity = 0.5,
    this.gridMinorOpacity = 0.3,
    this.gridMajorSpacing = 1.0,
    this.gridMinorSpacing = 0.2,
    this.axisColor = Colors.black,
    this.axisOpacity = 1.0,
    this.axisTickInterval = 1.0,
    this.axisLabelFormat = 'integer',  // Default to integer format
    this.frameStrokeColor = Colors.black,
    this.frameStrokeWidth = 2.0,
    this.frameStrokeOpacity = 1.0,
    this.frameFill = false,
    this.frameFillColor = Colors.white,
    this.frameFillOpacity = 1.0,
    this.showAxes = true,
    this.showGrid = true,
    this.showFrame = true,
  });

  /// Creates a copy of this config with the given fields replaced
  DiagramConfig copyWith({
    double? width,
    double? height,
    double? xRangeMin,
    double? xRangeMax,
    double? yRangeMin,
    double? yRangeMax,
    Color? gridMajorColor,
    Color? gridMinorColor,
    double? gridMajorOpacity,
    double? gridMinorOpacity,
    double? gridMajorSpacing,
    double? gridMinorSpacing,
    Color? axisColor,
    double? axisOpacity,
    double? axisTickInterval,
    String? axisLabelFormat,
    Color? frameStrokeColor,
    double? frameStrokeWidth,
    double? frameStrokeOpacity,
    bool? frameFill,
    Color? frameFillColor,
    double? frameFillOpacity,
    bool? showAxes,
    bool? showGrid,
    bool? showFrame,
  }) {
    return DiagramConfig(
      width: width ?? this.width,
      height: height ?? this.height,
      xRangeMin: xRangeMin ?? this.xRangeMin,
      xRangeMax: xRangeMax ?? this.xRangeMax,
      yRangeMin: yRangeMin ?? this.yRangeMin,
      yRangeMax: yRangeMax ?? this.yRangeMax,
      gridMajorColor: gridMajorColor ?? this.gridMajorColor,
      gridMinorColor: gridMinorColor ?? this.gridMinorColor,
      gridMajorOpacity: gridMajorOpacity ?? this.gridMajorOpacity,
      gridMinorOpacity: gridMinorOpacity ?? this.gridMinorOpacity,
      gridMajorSpacing: gridMajorSpacing ?? this.gridMajorSpacing,
      gridMinorSpacing: gridMinorSpacing ?? this.gridMinorSpacing,
      axisColor: axisColor ?? this.axisColor,
      axisOpacity: axisOpacity ?? this.axisOpacity,
      axisTickInterval: axisTickInterval ?? this.axisTickInterval,
      axisLabelFormat: axisLabelFormat ?? this.axisLabelFormat,
      frameStrokeColor: frameStrokeColor ?? this.frameStrokeColor,
      frameStrokeWidth: frameStrokeWidth ?? this.frameStrokeWidth,
      frameStrokeOpacity: frameStrokeOpacity ?? this.frameStrokeOpacity,
      frameFill: frameFill ?? this.frameFill,
      frameFillColor: frameFillColor ?? this.frameFillColor,
      frameFillOpacity: frameFillOpacity ?? this.frameFillOpacity,
      showAxes: showAxes ?? this.showAxes,
      showGrid: showGrid ?? this.showGrid,
      showFrame: showFrame ?? this.showFrame,
    );
  }
}
