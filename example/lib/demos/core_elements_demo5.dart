import 'package:flutter/material.dart';
import 'package:diagram_core/diagram_core.dart';

class CoreElementsDemo5 extends StatefulWidget {
  const CoreElementsDemo5({super.key});

  @override
  State<CoreElementsDemo5> createState() => _CoreElementsDemo5State();
}

class _CoreElementsDemo5State extends State<CoreElementsDemo5> {
  late final CoreElementsDiagram5 _diagram;

  @override
  void initState() {
    super.initState();
    _diagram = CoreElementsDiagram5(
      config: DiagramConfig(
        width: 600,
        height: 600,
        xRangeMin: -5,
        xRangeMax: 5,
        yRangeMin: -5,
        yRangeMax: 5,
        gridMajorSpacing: 1.0,
        gridMinorSpacing: 0.5,
        axisTickInterval: 1.0,
        axisLabelFormat: "integer",
        showGrid: true,
        showAxes: true,
        showFrame: true,
      ),
    );
    _diagram.initializeComponents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Core Elements Demo 5'),
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

class CoreElementsDiagram5 extends CoreDiagramBase {
  CoreElementsDiagram5({required DiagramConfig config}) : super(config: config);

  @override
  List<DrawableElement> createDiagramElements() {
    final elements = <DrawableElement>[];
    
    if (config.showGrid) {
      elements.add(GridElement(
        x: 0,
        y: 0,
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

    if (config.showFrame) {
      elements.add(FrameElement(
        x: (config.xRangeMax + config.xRangeMin) / 2,
        y: (config.yRangeMax + config.yRangeMin) / 2,
        width: config.xRangeMax - config.xRangeMin,
        height: config.yRangeMax - config.yRangeMin,
        color: Colors.blue,
        borderStyle: FrameBorderStyle(
          color: Colors.blue,
          strokeWidth: 2.0,
          cornerRadius: 0.0,
        ),
        backgroundColor: null,
      ));
    }

    if (config.showAxes) {
      elements.addAll([
        AxisElement(
          x: 0,
          y: 0,
          color: Colors.black,
          orientation: AxisOrientation.horizontal,
          majorTickInterval: config.axisTickInterval,
          labelFormatter: config.axisLabelFormat == "integer" ? 
            (value) => value.toInt().toString() : 
            (value) => value.toStringAsFixed(1),
          style: AxisStyle(
            color: Colors.black,
            strokeWidth: 2.0,
            tickLength: 0.2,
            tickLabelGap: 0.1,
            labelStyle: const TextStyle(
              color: Colors.black,
              fontSize: 14.0,
            ),
          ),
        ),
        AxisElement(
          x: 0,
          y: 0,
          color: Colors.black,
          orientation: AxisOrientation.vertical,
          majorTickInterval: config.axisTickInterval,
          labelFormatter: config.axisLabelFormat == "integer" ? 
            (value) => value.toInt().toString() : 
            (value) => value.toStringAsFixed(1),
          style: AxisStyle(
            color: Colors.black,
            strokeWidth: 2.0,
            tickLength: 0.2,
            tickLabelGap: 0.1,
            labelStyle: const TextStyle(
              color: Colors.black,
              fontSize: 14.0,
            ),
          ),
        ),
      ]);
    }

    // Add the rectangle last, after all core elements
    if (shapeFactory != null) {
      elements.add(shapeFactory.createRectangle(
        centerX: 0,
        centerY: 2,
        width: 2,
        height: 1,
        color: Colors.blue,
        fillColor: Colors.blue.withOpacity(0.2),
      ));
    }

    return elements;
  }
}
