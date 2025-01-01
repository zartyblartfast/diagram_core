# Element Migration Plan

## Objective
Integrate the builder and factory patterns from the legacy project while maintaining and leveraging our current DrawableElement implementation.

## Key Principles
1. **Preserve Core Implementation**: Keep the current DrawableElement as the base class for all diagram elements
2. **Factory Integration**: Adapt legacy factories to work with our existing element hierarchy
3. **Builder Enhancement**: Layer builders on top of current implementation without disrupting it
4. **Validation Through Demos**: Use core element demos to validate each migration step

## Current Architecture

### DrawableElement Base Class
```dart
abstract class DrawableElement {
  double x;
  double y;
  Color color;
  double opacity;
  Matrix4? transform;

  void paint(Canvas canvas, CoordinateSystem coordinates);
  void paintElement(Canvas canvas, CoordinateSystem coordinates);
  Rect getBounds();
  void update(Map<String, dynamic> state);
}
```

This proven implementation provides:
- Essential positioning (x, y)
- Basic styling (color, opacity)
- Transform support
- Canvas state management
- Consistent drawing interface

## Directory Structure

```
lib/src/
├── config/               # Configuration classes
├── controller/          # Diagram controllers
├── coordinate/          # Coordinate system
├── elements/            # Base elements and implementations
│   ├── drawable_element.dart
│   ├── grid_element.dart
│   ├── frame_element.dart
│   ├── axis_element.dart
│   └── shapes/          # New element types
│       ├── circle_element.dart
│       └── rectangle_element.dart
├── factories/           # Element creation
│   ├── element_factory.dart        # Base factory
│   ├── core_element_factory.dart   # Grid/Frame/Axis factory
│   └── shape_element_factory.dart  # Circle/Rectangle factory
├── builders/            # Element construction
│   ├── element_builder.dart        # Base builder
│   ├── core_element_builder.dart   # Grid/Frame/Axis builder
│   └── shape_element_builder.dart  # Circle/Rectangle builder
├── layer/              # Layer management
├── renderer/           # Rendering system
├── state/              # State management
├── themes/             # Theme system
│   ├── core_theme.dart          # Base theme definition
│   ├── theme_registry.dart      # Theme registration and management
│   └── built_in/                # Built-in themes
│       └── monochrome_theme.dart # Initial theme implementation
└── widgets/            # Flutter widgets
```

This structure:
1. Maintains existing organization while adding new components
2. Separates element creation (factories) from construction (builders)
3. Groups related functionality together
4. Provides clear locations for future extensions
5. Follows Flutter/Dart best practices for package organization

## Theme System

### Initial Implementation
Focus on core elements first while establishing a framework for future expansion.

#### Directory Structure
```
lib/src/
└── themes/                
    ├── core_theme.dart          # Base theme definition
    ├── theme_registry.dart      # Theme registration and management
    └── built_in/               
        └── monochrome_theme.dart # Initial theme implementation
```

#### Core Components

1. **Theme Registry**
```dart
class ThemeRegistry {
  static final ThemeRegistry instance = ThemeRegistry._();
  
  final Map<String, CoreTheme> _themes = {};
  String _currentThemeId = 'monochrome';
  
  // Register a new theme
  void registerTheme(CoreTheme theme) {
    _themes[theme.id] = theme;
  }
  
  // Get current theme
  CoreTheme get currentTheme => _themes[_currentThemeId]!;
  
  // Toggle between registered themes
  void toggleTheme() {
    var themeIds = _themes.keys.toList();
    var currentIndex = themeIds.indexOf(_currentThemeId);
    _currentThemeId = themeIds[(currentIndex + 1) % themeIds.length];
  }
}
```

2. **Base Theme Definition**
```dart
class CoreTheme {
  final String id;
  final String name;
  final Map<String, Color> colors;
  
  const CoreTheme({
    required this.id,
    required this.name,
    required this.colors,
  });
  
  // Extension point for future theme properties
  CoreTheme copyWith({
    Map<String, Color>? colors,
  }) {
    return CoreTheme(
      id: id,
      name: name,
      colors: colors ?? this.colors,
    );
  }
}
```

### Integration Strategy

1. **Phase 1: Core Elements Theme Support**
   - Implement CoreTheme and ThemeRegistry
   - Create monochrome theme
   - Add theme toggle to CoreDiagramBase
   - Update core element demos

2. **Phase 2: Theme Extension Points**
   - Add theme property interfaces
   - Create theme builder system
   - Prepare for custom themes

3. **Future Phases**
   - Add more built-in themes
   - Implement theme persistence
   - Add theme customization UI
   - Support JSON theme definitions

### Core Elements Integration
```dart
class CoreDiagramBase {
  // Theme support
  CoreTheme get currentTheme => ThemeRegistry.instance.currentTheme;
  
  void toggleTheme() {
    ThemeRegistry.instance.toggleTheme();
    rebuildElements();
  }
  
  // Element creation using theme
  @protected
  List<DrawableElement> createElements() {
    return [
      createGrid(),
      createFrame(),
      createAxes(),
    ];
  }
  
  @protected
  GridElement createGrid() => GridElement(
    color: currentTheme.colors['grid']!,
    // ... other properties
  );
}
```

### Demo Integration
```dart
class CoreElementsDemo extends StatefulWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.palette),
            onPressed: () => _diagram.toggleTheme(),
          ),
        ],
      ),
      body: DiagramWidget(controller: _diagram),
    );
  }
}
```

### Success Criteria for Initial Implementation
1. Working theme toggle in core element demos
2. Clean extension points for future themes
3. No breaking changes required for future expansion
4. Minimal but complete theme definition
5. Easy registration of new themes

## Required Elements for Theme Support

### RectangleElement
1. **Positioning Modes**
   - Center-referenced (preferred for new code)
   - Top-left referenced (for background elements)

2. **Factory Methods**
   - `.background()` - For theme backgrounds
   - `.centered()` - For general use

3. **Features**
   - Fill color and opacity
   - Stroke width
   - Border radius support
   - Transform support

### Integration Points
1. **Theme Factory Usage**
   - Background element creation
   - Grid element styling
   - Frame element configuration
   - Axis element theming

2. **Factory Structure**
   - Base ElementFactory
   - CoreElementFactory for basic elements
   - ShapeElementFactory for shapes (including Rectangle)

## Migration Phases

### Phase 1: Factory Integration
**Focus**: Add factory support while preserving current element implementations

1. **Create Element Factory**
```dart
class ElementFactory {
  final DiagramConfig config;
  
  // Factory methods use existing element implementations
  GridElement createGrid() => GridElement(
    color: config.gridColor,
    majorSpacing: config.gridMajorSpacing,
    // ... other properties
  );
  
  FrameElement createFrame() => FrameElement(
    color: config.frameColor,
    width: config.frameWidth,
    // ... other properties
  );
}
```

2. **Update CoreDiagramBase**
```dart
class CoreDiagramBase {
  late final ElementFactory elementFactory;

  @protected
  void initializeFactories() {
    elementFactory = createElementFactory();
  }

  @protected
  ElementFactory createElementFactory() {
    return ElementFactory(config: config);
  }
}
```

### Phase 2: Builder Integration
**Focus**: Add builders while maintaining direct element creation as an option

1. **Element Builders**
```dart
class ElementBuilder {
  final ElementFactory factory;
  
  // Builders work with existing element types
  List<DrawableElement> buildElements() {
    return [
      factory.createGrid(),
      factory.createFrame(),
      factory.createAxes(),
    ];
  }
}
```

2. **Optional Builder Support in CoreDiagramBase**
```dart
class CoreDiagramBase {
  ElementBuilder? elementBuilder;

  List<DrawableElement> createDiagramElements() {
    // Support both direct creation and builder pattern
    if (elementBuilder != null) {
      return elementBuilder.buildElements();
    }
    return createElementsDirectly();
  }

  // Preserve current direct creation method
  List<DrawableElement> createElementsDirectly() {
    return [
      elementFactory.createGrid(),
      elementFactory.createFrame(),
      // ...
    ];
  }
}
```

### Phase 3: New Element Types
**Focus**: Add new element types using the established pattern

1. **Create New Elements**
```dart
class CircleElement extends DrawableElement {
  final double radius;
  
  CircleElement({
    required super.x,
    required super.y,
    required super.color,
    required this.radius,
  });
  
  @override
  void paintElement(Canvas canvas, CoordinateSystem coordinates) {
    // Implementation
  }
}
```

2. **Extend Factory**
```dart
class ElementFactory {
  CircleElement createCircle() => CircleElement(
    x: 0,
    y: 0,
    color: config.defaultColor,
    radius: 1.0,
  );
}
```

## Progress Update (2025-01-01)

### Completed Tasks
1. **Core Element Integration**
   - Integrated GridElement with coordinates requirement
   - Implemented AxisElement with configurable integer labels
   - Added FrameElement with style configuration
   - Created ShapeElementFactory for shape creation
   - Fixed initialization order in CoreDiagramBase for proper factory setup

### Validation
1. **Demo Implementation**
   - Created core_elements_demo5.dart demonstrating:
     - Grid with 1-unit major spacing
     - Axes with 1-unit tick intervals and integer labels
     - Frame with specified styles
     - Rectangle (2x1) drawn at (0,2) using ShapeElementFactory
   - Verified coordinate system scaling with different ranges (-5 to +5)
   - Confirmed proper element positioning and scaling

### Next Steps
1. **Theme Support**
   - Implement theme property interfaces
   - Create theme builder system
   - Add theme support to all elements
   - Create demo showcasing theme switching

2. **Additional Shape Support**
   - Add more shape types to ShapeElementFactory
   - Create demos for new shapes
   - Implement style configuration for shapes

## Validation Strategy

### 1. Incremental Testing
For each phase:
1. Create demo using current DrawableElement implementations
2. Add factory support
3. Add builder support
4. Verify all features still work

### 2. Integration Points
```dart
// Example of a complete demo using both patterns
class ShapeElementsDemo extends CoreDiagramBase {
  @override
  void initializeComponents() {
    super.initializeComponents();
    
    // Can use factory directly
    final circle = elementFactory.createCircle();
    
    // Or use builder pattern
    elementBuilder = ShapeElementBuilder(factory: elementFactory)
      .withCircle(x: 0, y: 0, radius: 2);
  }
}
```

### 3. JSON Schema Updates
Maintain JSON templates that work with both patterns:
```json
{
  "elements": {
    "factory": {
      "circle": {
        "x": 0,
        "y": 0,
        "radius": 2
      }
    },
    "builder": {
      "shapes": [
        {
          "type": "circle",
          "properties": {
            "x": 0,
            "y": 0,
            "radius": 2
          }
        }
      ]
    }
  }
}
```

## Next Steps
1. Implement ElementFactory with current element types
2. Create first builder implementation
3. Test with existing demos
4. Begin adding new element types

## Success Criteria
1. All current functionality preserved
2. Factory and builder patterns available but optional
3. JSON templates support both patterns
4. Clear path for adding new elements
5. Existing demos continue to work without modification
