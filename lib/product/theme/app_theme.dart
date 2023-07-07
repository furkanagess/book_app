import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class AppTheme {
  ThemeData get theme {
    return ThemeData(
      brightness: Brightness.dark,
      appBarTheme: _appBarTheme,
      scaffoldBackgroundColor: AppColors.background,
    );
  }

  AppBarTheme get _appBarTheme => AppBarTheme(
        backgroundColor: AppColors.transparent,
        centerTitle: true,
        elevation: 0,
      );
}
