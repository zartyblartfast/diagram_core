import '../elements/drawable_element.dart';
import '../factories/element_factory.dart';

/// Base builder class for constructing diagram elements
abstract class ElementBuilder {
  final ElementFactory factory;

  const ElementBuilder({required this.factory});

  List<DrawableElement> buildElements();
}
