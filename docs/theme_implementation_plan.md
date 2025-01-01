# Theme Implementation Plan

## Core Principles

### 1. Factory Pattern Integration
- All elements must be created through factories
- Direct element creation is not allowed
- Factories are part of the CoreDiagram class hierarchy

### 2. Theme Factory Structure
- Location: `lib/src/themes/theme_element_factory.dart`
- Purpose: Creates theme-aware elements (background, grid, frame)
- Integration: Used within CoreDiagram's createElements() method
- Pattern: Following legacy project's DiagramThemeFactory approach

### 3. Theme Components
#### Theme Definitions (`lib/src/themes/`)
- `core_theme.dart`: Base theme class
- `theme_registry.dart`: Theme management
- `built_in/monochrome_theme.dart`: Default themes
  - Light theme colors:
    - background: Colors.white
    - element: Colors.black
    - grid: Colors.black54 (0x8A000000)
    - gridMinor: Colors.black26 (0x42000000)
  - Dark theme colors:
    - background: Color(0xFF1E1E1E)
    - element: Colors.white
    - grid: Colors.white54 (0x8AFFFFFF)
    - gridMinor: Colors.white26 (0x42FFFFFF)

### 4. CoreDiagram Integration
```
CoreDiagram
├── createRenderer()
├── createLayer()
├── createCoordinateSystem()
├── createStateManager()
└── createElements()  <-- Theme factory usage point
```

### 5. UI Implementation
- Theme toggle button placed below diagram
- Uses Icons.dark_mode/light_mode icons
- Follows legacy project's state_managed_diagram2.dart pattern

## Required Elements

### RectangleElement and ShapeElementFactory
- RectangleElement Location: `lib/src/elements/shapes/rectangle_element.dart`
- ShapeElementFactory Location: `lib/src/factories/shape_element_factory.dart`
- Purpose: 
  - RectangleElement for theme background and general rectangle shapes
  - ShapeElementFactory for creating all shape elements including rectangles
- Features:
  - RectangleElement:
    - Center and top-left positioning
    - Fill and stroke support
    - Border radius option
  - ShapeElementFactory:
    - Background factory for themes
    - Centered factory for general use
    - Integrated with CoreDiagramBase

### Implementation Order
1. Create RectangleElement with required features
2. Create ShapeElementFactory for creating rectangles
3. Update ThemeElementFactory to use ShapeElementFactory
4. Implement theme demo with all core elements

## Implementation Steps

1. Create ThemeElementFactory
   - Static methods for creating themed elements
   - Uses theme colors from ThemeRegistry
   - Creates background, grid, and frame elements

2. Update Demo Implementation
   - Use JSON configuration as source of truth
   - Implement theme toggle button
   - Use ThemeElementFactory for element creation
   - Ensure background element is created first

3. Integration Points
   - ThemeRegistry for theme management
   - CoreElementFactory for business elements
   - ThemeElementFactory for themed elements

## Key Requirements

1. Never create elements directly
2. Always use factory pattern
3. Background element is crucial for theme visibility
4. Follow CoreDiagram class hierarchy
5. Maintain consistency with legacy implementation

## Notes
- Theme factory location chosen to keep theme-related code together
- Factory remains part of CoreDiagram ecosystem despite location
- Theme toggle follows legacy project's implementation
- All element creation must go through appropriate factories
