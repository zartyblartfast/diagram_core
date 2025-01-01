import 'package:flutter/material.dart';
import 'package:diagram_core/diagram_core.dart';
import 'dart:math' as math;

/// Demonstrates the usage of core elements (Grid, Axis, Frame)
class CoreElementsDemo extends StatefulWidget {
  const CoreElementsDemo({super.key});

  @override
  State<CoreElementsDemo> createState() => _CoreElementsDemoState();
}

class _CoreElementsDemoState extends State<CoreElementsDemo> {
  late final CoreElementsDiagram _diagram;

  @override
  void initState() {
    super.initState();
    _diagram = CoreElementsDiagram(
      config: DiagramConfig(
        // Use square canvas with -10 to +10 coordinate range
        width: 600,
        height: 600,
        xRangeMin: -10,
        xRangeMax: 10,
        yRangeMin: -10,
        yRangeMax: 10,
        // Grid and axis settings
        gridMajorSpacing: 2.0,
        gridMinorSpacing: 0.5,
        axisTickInterval: 2.0,
        // Show all elements
        showGrid: true,
        showAxes: true,
        showFrame: true,
      ),
    );
    print('Created diagram');
    _diagram.initializeComponents();
    print('Initialized diagram components');
  }

  @override
  Widget build(BuildContext context) {
    print('Building CoreElementsDemo');
    print('Diagram config dimensions: ${_diagram.config.width}x${_diagram.config.height}');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Core Elements Demo'),
      ),
      body: Center(
        child: DiagramWidget(controller: _diagram),
      ),
    );
  }

  @override
  void dispose() {
    _diagram.dispose();
    super.dispose();
  }
}

/// A diagram that demonstrates core elements working together
class CoreElementsDiagram extends CoreDiagramBase {
  CoreElementsDiagram({required DiagramConfig config}) : super(config: config);

  @override
  List<DrawableElement> createDiagramElements() {
    print('Creating diagram elements...');
    final elements = <DrawableElement>[];
    
    // Add grid element first (drawn underneath)
    if (showGrid) {
      print('Adding grid element');
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
    print('Adding frame element');
    final frameWidth = config.xRangeMax - config.xRangeMin;
    final frameHeight = config.yRangeMax - config.yRangeMin;
    print('Frame dimensions: width=$frameWidth, height=$frameHeight');
    print('Diagram config: width=${config.width}, height=${config.height}');
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
    print('Frame element added with blue border and transparent background');
    
    // Add axes if enabled (drawn on top)
    if (showAxes) {
      print('Adding axis elements');
      // Draw X axis
      elements.add(AxisElement(
        x: 0,  // Start at origin
        y: 0,  // Place at origin
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
      
      // Draw Y axis
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
    
    print('Created ${elements.length} elements');
    return elements;
  }
}
