import 'package:flutter/material.dart';
import '../config/diagram_config.dart';
import '../elements/drawable_element.dart';

/// Base factory class for creating diagram elements
abstract class ElementFactory {
  final DiagramConfig config;

  const ElementFactory({required this.config});
}
