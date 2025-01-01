import 'package:flutter/material.dart';
import 'package:diagram_core/diagram_core.dart';

/// Demonstrates the usage of core elements (Grid, Axis, Frame) with a different coordinate layout
class CoreElementsDemo2 extends StatefulWidget {
  const CoreElementsDemo2({super.key});

  @override
  State<CoreElementsDemo2> createState() => _CoreElementsDemo2State();
}

class _CoreElementsDemo2State extends State<CoreElementsDemo2> {
  late final CoreElementsDiagram2 _diagram;

  @override
  void initState() {
    super.initState();
    _diagram = CoreElementsDiagram2(
      config: DiagramConfig(
        width: 600,
        height: 600,
        xRangeMin: -5,
        xRangeMax: 5,
        yRangeMin: 0,
        yRangeMax: 10,
        // Grid and axis settings with unit spacing
        gridMajorSpacing: 1.0,  // Changed from 2.0 to show major lines at every unit
        gridMinorSpacing: 0.2,  // Changed from 0.5 to show 5 minor divisions per unit
        axisTickInterval: 1.0,  // Changed from 2.0 to show labels at every unit
      ),
    );
    _diagram.initializeComponents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Core Elements Demo 2'),
      ),
      body: Center(
        child: DiagramWidget(controller: _diagram),
      ),
    );
  }
}

/// A diagram that demonstrates core elements working together with modified coordinate layout
class CoreElementsDiagram2 extends CoreDiagramBase {
  CoreElementsDiagram2({
    required super.config,
  });

  @override
  List<DrawableElement> createDiagramElements() {
    final elements = <DrawableElement>[];
    
    // Add grid element first (drawn underneath)
    if (showGrid) {
      elements.add(GridElement(
        color: Colors.grey.shade300,
        majorSpacing: config.gridMajorSpacing,
        minorSpacing: config.gridMinorSpacing,
        coordinates: coordinates,  // Use the coordinates property from CoreDiagramBase
        majorStyle: GridLineStyle(
          color: Colors.grey.shade400,
          strokeWidth: 1.0,
        ),
        minorStyle: GridLineStyle(
          color: Colors.grey.shade300,
          strokeWidth: 0.5,
        ),
      ));
    }
    
    // Add frame element (drawn behind axes)
    final frameWidth = config.xRangeMax - config.xRangeMin;
    final frameHeight = config.yRangeMax - config.yRangeMin;
    elements.add(FrameElement(
      x: (config.xRangeMax + config.xRangeMin) / 2,  // Center point
      y: (config.yRangeMax + config.yRangeMin) / 2,  // Center point
      width: frameWidth,
      height: frameHeight,
      color: Colors.blue,
      borderStyle: FrameBorderStyle(
        color: Colors.blue,
        strokeWidth: 2.0,
        cornerRadius: 0.0,  // Remove corner radius
      ),
      backgroundColor: null,  // Set background color to null for transparency
      cornerDecoration: null,  // Remove corner decoration
      padding: EdgeInsets.zero,  // Remove padding
    ));
    
    // Add axes if enabled (drawn on top)
    if (showAxes) {
      // Draw X axis at y = 0
      elements.add(AxisElement(
        x: 0,  // Start at origin
        y: 0,  // Place at y = 0
        color: Colors.black,
        orientation: AxisOrientation.horizontal,
        majorTickInterval: config.axisTickInterval,
        minorTickInterval: config.axisTickInterval / 5,
        style: AxisStyle(
          color: Colors.black,
          strokeWidth: 2.0,
          labelStyle: TextStyle(
            color: Colors.black,
            fontSize: 14.0,
          ),
          tickLength: 0.2,  // 0.2 diagram units
          tickLabelGap: 0.1,  // 0.1 diagram units
        ),
        labelFormatter: (value) => value.toStringAsFixed(0),
      ));
      
      // Draw Y axis at x = 0
      elements.add(AxisElement(
        x: 0,  // Place at origin
        y: 0,  // Start at origin
        color: Colors.black,
        orientation: AxisOrientation.vertical,
        majorTickInterval: config.axisTickInterval,
        minorTickInterval: config.axisTickInterval / 5,
        style: AxisStyle(
          color: Colors.black,
          strokeWidth: 2.0,
          labelStyle: TextStyle(
            color: Colors.black,
            fontSize: 14.0,
          ),
          tickLength: 0.2,  // 0.2 diagram units
          tickLabelGap: 0.1,  // 0.1 diagram units
        ),
        labelFormatter: (value) => value.toStringAsFixed(0),
      ));
    }
    
    return elements;
  }
}
