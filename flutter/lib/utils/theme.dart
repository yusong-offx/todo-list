import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

class MyTheme with ChangeNotifier {
  var _modeSwitch = true;
  ThemeMode get mode => _modeSwitch ? ThemeMode.light : ThemeMode.dark;

  final light = FlexThemeData.light(
    scheme: FlexScheme.greyLaw,
    surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
    blendLevel: 20,
    appBarOpacity: 0.95,
    subThemesData: const FlexSubThemesData(
      blendOnLevel: 20,
      blendOnColors: false,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
  );
  final dark = FlexThemeData.dark(
    scheme: FlexScheme.greyLaw,
    surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
    blendLevel: 15,
    appBarStyle: FlexAppBarStyle.background,
    appBarOpacity: 0.90,
    subThemesData: const FlexSubThemesData(
      blendOnLevel: 30,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
  );

  void switchThemeMode() {
    _modeSwitch = !_modeSwitch;
    notifyListeners();
  }
}
