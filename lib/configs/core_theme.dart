import 'package:flutter/material.dart';

import 'app_theme.dart';

const fontFamily = 'Poppins';

final themeLight = ThemeData(
  fontFamily: fontFamily,
  brightness: Brightness.light,
  dividerColor: Colors.white60,
  splashColor: Colors.transparent,
  primaryColor: const Color(0xffee8f8b),
  scaffoldBackgroundColor: Colors.white,
  colorScheme: ThemeData.light()
      .colorScheme
      .copyWith(
        brightness: Brightness.light,
        primary: AppTheme.light.primary,
        background: AppTheme.light.background,
      )
      .copyWith(background: Colors.white),
);
