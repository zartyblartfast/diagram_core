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
    _connectRenderer();
  }

  void _connectRenderer() {
    widget.controller.connectRenderer(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void didUpdateWidget(DiagramWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      _connectRenderer();
    }
  }

  @override
  Widget build(BuildContext context) {
    final config = widget.controller.config;
    
    return SizedBox(
      width: config.width,
      height: config.height,
      child: widget.controller.buildWidget(),
    );
  }
}
