import 'package:material_ui/material_ui.dart';

abstract final class AppTypography {
  static const String fontFamily = 'Roboto';

  static const TextStyle heading = TextStyle(
    fontFamily: fontFamily,
    fontSize: 10,
    fontWeight: FontWeight.w600,
    height: 1.25,
  );

  static const TextStyle body = TextStyle(
    fontFamily: fontFamily,
    fontSize: 8,
    fontWeight: FontWeight.w400,
    height: 1.25,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: fontFamily,
    fontSize: 6,
    fontWeight: FontWeight.w400,
    height: 1.25,
  );
}
