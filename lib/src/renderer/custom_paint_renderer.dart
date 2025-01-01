import 'package:flutter/material.dart';
import 'diagram_renderer_base.dart';
import '../config/diagram_config.dart';

/// Renderer that uses Flutter's CustomPaint for diagram rendering
class CustomPaintRenderer extends DiagramRendererBase {
  CustomPaintRenderer({
    required DiagramConfig config,
  }) : super(config: config);

  @override
  Widget buildDiagramWidget() {
    return RepaintBoundary(
      child: SizedBox(  // Ensure CustomPaint fills the container
        width: config.width,
        height: config.height,
        child: CustomPaint(
          size: Size(config.width, config.height),
          painter: _DiagramPainter(this),
          isComplex: true,  // Hint that painting is complex
          willChange: true,  // Hint that painting will change
        ),
      ),
    );
  }

  @override
  void updateView() {
    // This method would be connected to a StatefulWidget's setState
    // The actual implementation would be provided by a mixin or wrapper widget
  }

  @override
  void _applyCanvasTransform(Canvas canvas, Size size) {
    // No canvas transform needed - CoordinateSystem handles all transformations
  }
}

/// Custom painter that delegates to the renderer
class _DiagramPainter extends CustomPainter {
  final CustomPaintRenderer renderer;

  _DiagramPainter(this.renderer);

  @override
  void paint(Canvas canvas, Size size) {
    renderer.paint(canvas, size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // Always repaint for now
    // Could be optimized by comparing specific properties
    return true;
  }
}
