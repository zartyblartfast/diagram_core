import '../elements/drawable_element.dart';
import '../factories/core_element_factory.dart';
import 'element_builder.dart';

/// Builder for constructing core diagram elements (Grid, Frame, Axis)
class CoreElementBuilder extends ElementBuilder {
  const CoreElementBuilder({
    required CoreElementFactory factory,
  }) : super(factory: factory);

  @override
  List<DrawableElement> buildElements() {
    return [];  // To be implemented
  }
}
