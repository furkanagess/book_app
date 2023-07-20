import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class AppTheme {
  ThemeData get theme {
    return ThemeData(
      brightness: Brightness.dark,
      appBarTheme: _appBarTheme,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: _colorScheme,
    );
  }

  AppBarTheme get _appBarTheme => AppBarTheme(
        backgroundColor: AppColors.transparent,
        centerTitle: true,
        elevation: 0,
      );

  ColorScheme get _colorScheme => const ColorScheme(
        brightness: Brightness.light,
        primary: Color(0xff1db954), // used
        onPrimary: Color(0xFFFFFFFF), // used
        secondary: Color(0xff535353), // used
        onSecondary: Colors.blue,
        error: Color(0xFFF44336), // used
        onError: Colors.red,
        background: Color(0xff121212), // used
        onBackground: Color(0xff212121), // used
        surface: Color(0xffb3b3b3), // used
        onSurface: Color(0x00000000), // used
      );
}
