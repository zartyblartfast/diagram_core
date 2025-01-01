# Diagram Core

A Flutter framework for creating structured and maintainable diagrams.

## Project Structure

```
diagram_core/
  ├── lib/
  │   ├── src/
  │   │   ├── controller/      # Coordination and control
  │   │   ├── renderer/        # Rendering system
  │   │   ├── layer/           # Layer management
  │   │   ├── state/          # State management
  │   │   ├── coordinate/      # Coordinate system
  │   │   ├── config/         # Configuration
  │   │   └── elements/       # Drawing elements
  │   └── diagram_core.dart    # Public API
  └── docs/
      └── implementation_roadmap.md  # Detailed implementation plan
```

## Architecture Overview

The framework is built around several key concepts:

1. **Controller Layer**
   - DiagramLayerController: Top-level coordinator
   - CoreDiagramBase: Base implementation with common functionality

2. **Rendering System**
   - DiagramRendererBase: Abstract rendering interface
   - CustomPaintRenderer: Flutter CustomPaint implementation

3. **Layer System**
   - IDiagramLayer: Layer interface
   - BasicDiagramLayer: Standard implementation

4. **State Management**
   - DiagramStateManager: Handles diagram state
   - Supports reactive updates

5. **Coordinate System**
   - Handles coordinate transformations
   - Supports custom coordinate spaces

## Implementation Status

This project is under active development. See [Implementation Roadmap](docs/implementation_roadmap.md) for:
- Current status
- Planned features
- Migration guide
- Development phases

## Getting Started

Add to your pubspec.yaml:
```yaml
dependencies:
  diagram_core:
    git:
      url: https://github.com/zartyblartfast/diagram_core.git
```

Basic usage:
```dart
class MyDiagram extends CoreDiagramBase {
  MyDiagram({required DiagramConfig config}) : super(config: config);

  @override
  List<DrawableElement> createDiagramElements() {
    // Create and return your diagram elements
  }
}
```

## Next Steps

See the [Implementation Roadmap](docs/implementation_roadmap.md) for detailed information about:
- Core element implementation
- Widget integration
- Example implementations
- Documentation plans
- Testing strategy
- Migration guide
