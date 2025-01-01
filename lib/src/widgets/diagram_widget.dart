import 'package:flutter/material.dart';
import '../controller/diagram_layer_controller.dart';

/// A widget that displays a diagram and handles updates
class DiagramWidget extends StatefulWidget {
  final DiagramLayerController controller;

  const DiagramWidget({
    super.key,
    required this.controller,
  });

  @override
  State<DiagramWidget> createState() => _DiagramWidgetState();
}

class _DiagramWidgetState extends State<DiagramWidget> {
  @override
  void initState() {
    super.initState();
    print('DiagramWidget initState');
    // Connect the renderer's updateView to setState
    _connectRenderer();
  }

  void _connectRenderer() {
    print('Connecting renderer to setState');
    // Use extension method to connect renderer to setState
    widget.controller.connectRenderer(() {
      print('Renderer requested update');
      if (mounted) {
        setState(() {
          print('Updating widget state');
        });
      }
    });
  }

  @override
  void didUpdateWidget(DiagramWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('DiagramWidget didUpdateWidget');
    if (widget.controller != oldWidget.controller) {
      _connectRenderer();
    }
  }

  @override
  Widget build(BuildContext context) {
    print('DiagramWidget build');
    final config = widget.controller.config;
    print('DiagramWidget config dimensions: ${config.width}x${config.height}');
    
    return SizedBox(
      width: config.width,
      height: config.height,
      child: widget.controller.buildWidget(),
    );
  }
}
