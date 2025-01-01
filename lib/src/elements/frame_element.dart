import 'package:flutter/material.dart';
import '../coordinate/coordinate_system.dart';
import 'drawable_element.dart';

/// Configuration for frame border appearance
class FrameBorderStyle {
  final Color color;
  final double strokeWidth;
  final List<double>? dashPattern;
  final double cornerRadius;

  const FrameBorderStyle({
    required this.color,
    this.strokeWidth = 1.0,
    this.dashPattern,
    this.cornerRadius = 0.0,
  });
}

/// Configuration for frame corner decoration
class FrameCornerDecoration {
  final double size;
  final Color color;
  final double strokeWidth;
  final bool showTopLeft;
  final bool showTopRight;
  final bool showBottomLeft;
  final bool showBottomRight;

  const FrameCornerDecoration({
    this.size = 10.0,
    required this.color,
    this.strokeWidth = 1.0,
    this.showTopLeft = true,
    this.showTopRight = true,
    this.showBottomLeft = true,
    this.showBottomRight = true,
  });
}

/// A frame element that draws a border around content with optional styling
class FrameElement extends DrawableElement {
  /// Width of the frame
  final double width;
  
  /// Height of the frame
  final double height;
  
  /// Style for the frame border
  final FrameBorderStyle borderStyle;
  
  /// Optional background fill color
  final Color? backgroundColor;
  
  /// Optional corner decoration
  final FrameCornerDecoration? cornerDecoration;
  
  /// Optional padding inside the frame
  final EdgeInsets padding;

  FrameElement({
    required super.x,
    required super.y,
    required super.color,
    super.opacity = 1.0,
    super.transform,
    required this.width,
    required this.height,
    FrameBorderStyle? borderStyle,
    this.backgroundColor,
    this.cornerDecoration,
    this.padding = EdgeInsets.zero,
  }) : borderStyle = borderStyle ?? FrameBorderStyle(
         color: color,
         strokeWidth: 2.0,  // Increased default stroke width
       );

  @override
  void paintElement(Canvas canvas, CoordinateSystem coordinates) {
    print('Painting FrameElement');
    print('Frame coordinates: x=$x, y=$y, width=$width, height=$height');
    print('Coordinate scale: ${coordinates.scale}');
    print('Canvas size: ${coordinates.canvasSize}');

    // Calculate frame rect in diagram coordinates
    final left = x - width/2;
    final top = y - height/2;
    final right = left + width;
    final bottom = top + height;
    final rect = Rect.fromLTRB(left, top, right, bottom);
    
    print('Frame rect in diagram coordinates: $rect');

    // Convert frame rect to canvas coordinates
    final topLeftCanvas = coordinates.toCanvas(left, top);
    final bottomRightCanvas = coordinates.toCanvas(right, bottom);
    final rectCanvas = Rect.fromPoints(topLeftCanvas, bottomRightCanvas);

    print('Frame rect in canvas coordinates: $rectCanvas');

    // Draw background if specified
    if (backgroundColor != null) {
      final backgroundPaint = Paint()
        ..color = backgroundColor!.withOpacity(opacity)
        ..style = PaintingStyle.fill;
      
      print('Drawing background: color=${backgroundPaint.color}, opacity=$opacity');
      canvas.drawRect(rectCanvas, backgroundPaint);
    }

    // Draw border
    final borderPaint = Paint()
      ..color = borderStyle.color.withOpacity(opacity)
      ..strokeWidth = borderStyle.strokeWidth  // Remove scaling
      ..style = PaintingStyle.stroke;

    print('Drawing border: color=${borderPaint.color}, strokeWidth=${borderPaint.strokeWidth}, opacity=$opacity');
    print('Border style: color=${borderStyle.color}, strokeWidth=${borderStyle.strokeWidth}');
    canvas.drawRect(rectCanvas, borderPaint);

    // Draw corner decorations if specified
    if (cornerDecoration != null) {
      print('Drawing corner decorations');
      _drawCornerDecorations(canvas, coordinates, rectCanvas);
    }
  }

  /// Draws corner decorations at each corner of the frame
  void _drawCornerDecorations(Canvas canvas, CoordinateSystem coordinates, Rect rect) {
    final decorationPaint = Paint()
      ..color = cornerDecoration!.color.withOpacity(opacity)
      ..strokeWidth = cornerDecoration!.strokeWidth / coordinates.scale  // Scale stroke width
      ..style = PaintingStyle.stroke;

    final size = cornerDecoration!.size / coordinates.scale;

    // Top-left corner
    if (cornerDecoration!.showTopLeft) {
      canvas.drawLine(
        Offset(rect.left, rect.top + size),
        Offset(rect.left, rect.top),
        decorationPaint,
      );
      canvas.drawLine(
        Offset(rect.left, rect.top),
        Offset(rect.left + size, rect.top),
        decorationPaint,
      );
    }

    // Top-right corner
    if (cornerDecoration!.showTopRight) {
      canvas.drawLine(
        Offset(rect.right - size, rect.top),
        Offset(rect.right, rect.top),
        decorationPaint,
      );
      canvas.drawLine(
        Offset(rect.right, rect.top),
        Offset(rect.right, rect.top + size),
        decorationPaint,
      );
    }

    // Bottom-left corner
    if (cornerDecoration!.showBottomLeft) {
      canvas.drawLine(
        Offset(rect.left, rect.bottom - size),
        Offset(rect.left, rect.bottom),
        decorationPaint,
      );
      canvas.drawLine(
        Offset(rect.left, rect.bottom),
        Offset(rect.left + size, rect.bottom),
        decorationPaint,
      );
    }

    // Bottom-right corner
    if (cornerDecoration!.showBottomRight) {
      canvas.drawLine(
        Offset(rect.right - size, rect.bottom),
        Offset(rect.right, rect.bottom),
        decorationPaint,
      );
      canvas.drawLine(
        Offset(rect.right, rect.bottom - size),
        Offset(rect.right, rect.bottom),
        decorationPaint,
      );
    }
  }

  @override
  Rect getBounds() {
    return Rect.fromLTWH(
      x - width/2,
      y - height/2,
      width + padding.left + padding.right,
      height + padding.top + padding.bottom,
    );
  }
}
