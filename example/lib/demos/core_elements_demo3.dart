import 'package:flutter/material.dart';
import 'package:diagram_core/diagram_core.dart';

/// Demonstrates the usage of core elements (Grid, Axis, Frame) with an asymmetric x-range
class CoreElementsDemo3 extends StatefulWidget {
  const CoreElementsDemo3({super.key});

  @override
  State<CoreElementsDemo3> createState() => _CoreElementsDemo3State();
}

class _CoreElementsDemo3State extends State<CoreElementsDemo3> {
  late final CoreElementsDiagram3 _diagram;

  @override
  void initState() {
    super.initState();
    _diagram = CoreElementsDiagram3(
      config: DiagramConfig(
        width: 600,
        height: 600,
        xRangeMin: -2,
        xRangeMax: 8,
        yRangeMin: -5,
        yRangeMax: 5,
        gridMajorSpacing: 1.0,
        gridMinorSpacing: 0.2,
        axisTickInterval: 1.0,
      ),
    );
    _diagram.initializeComponents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Core Elements Demo 3'),
      ),
      body: Center(
        child: DiagramWidget(controller: _diagram),
      ),
    );
  }
}

/// A diagram that demonstrates core elements with asymmetric x-range and symmetric y-range
class CoreElementsDiagram3 extends CoreDiagramBase {
  CoreElementsDiagram3({
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
        coordinates: coordinates,
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
        cornerRadius: 0.0,
      ),
      backgroundColor: null,
      cornerDecoration: null,
      padding: EdgeInsets.zero,
    ));
    
    // Add axes if enabled (drawn on top)
    if (showAxes) {
      // Draw X axis
      elements.add(AxisElement(
        x: 0,
        y: 0,
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
          tickLength: 0.2,
          tickLabelGap: 0.1,
        ),
        labelFormatter: (value) => value.toStringAsFixed(0),
      ));
      
      // Draw Y axis
      elements.add(AxisElement(
        x: 0,
        y: 0,
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
          tickLength: 0.2,
          tickLabelGap: 0.1,
        ),
        labelFormatter: (value) => value.toStringAsFixed(0),
      ));
    }
    
    return elements;
  }
}
