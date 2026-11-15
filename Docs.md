# Design Tokens
Colors:
- surface: #FFFFFF
- onSurface: #000000
- accent: #8A47EB

Typography:
- heading: font size 15px, line height 125%, weight 600 
- body: font size 9px, line height 125%, weight 400
- caption: font size 8px, line height 125%, weight 400

Clip:
- button: 8px
- bottom sheet: 15px

# Reusable Components
- Primary Button
- Secondary Button
- Selectable Item Chip
- Pie Chart 
- Meal Card

# Widget Tree
- Toolbar
    - Row
        - Profile Icon
        - Hamburger Menu
- Free Trial Reward Banner
    - Row
        - Icon
        - Column
            - Title
            - Description
- Today's Progress Card
    - Row
        - Title
        - View More Button
    - 
- Recipe List
    - Recipe Card
        - Recipe Image
- Bottom Navigation Items


# Interactions 
1. Click on home meal card -> Open meal details
2. Press start cooking -> Open cooking instructions, the first part
3. Press finish cook -> Meal gets added to the days history

# Open Questions

- dark mode?
- images and recipes stored locally or on the cloud?
- ouside payment provider or build one in-house?

# Adding Figma Images and Icons

## Images

1. In Figma, select the image or frame and export it as PNG or JPG. Use SVG for
   vector illustrations that need to remain crisp at different sizes.
2. Add the exported file under `assets/images/` (create the directory if needed).
   Use descriptive, lowercase names such as `sesame_chicken_bowl.jpg`.
3. Register the directory in the `flutter` section of `pubspec.yaml`:

   ```yaml
   flutter:
     uses-material-design: true
     assets:
       - assets/images/
   ```

4. Run `flutter pub get`, then display the image with
   `Image.asset('assets/images/sesame_chicken_bowl.jpg', fit: BoxFit.cover)`.
   Keep 2x and 3x variants in `2.0x/` and `3.0x/` subdirectories next to the
   original when exporting density-specific raster images.

## Icons

- For simple icons, prefer a matching `Icons.*` or `CupertinoIcons.*` glyph
  already provided by Flutter.
- To use an exported Figma vector, export it as SVG and add
  `flutter_svg` to `pubspec.yaml`. Load it with `SvgPicture.asset(...)` and
  register the SVG in the same asset directory as above.
- Use a clear name for each exported icon, and preserve its intended view box
  and color. Prefer SVG for scalable single-color icons; use PNG when the
  design includes raster effects.

The home screen currently uses built-in icons and gradient recipe-image
placeholders. Replace those placeholders with `Image.asset` when the final
Figma exports are available.