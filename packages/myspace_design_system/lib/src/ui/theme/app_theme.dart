import 'package:flutter/material.dart';

class AppTheme {
  //singleton instance
  static final AppTheme _instance = AppTheme._internal();

  factory AppTheme() {
    return _instance;
  }

  AppTheme._internal();

  final _colorSchemeLight = ColorScheme.fromSeed(seedColor: Colors.blue, brightness: Brightness.light);
  final _colorSchemeDark = ColorScheme.fromSeed(seedColor: Colors.blue, brightness: Brightness.dark);

  final _textThemeLight = ThemeData.light().textTheme;
  final _textThemeDark = ThemeData.dark().textTheme;

  final _noBorder = const RoundedRectangleBorder();

  // Filled Button Theme Data

  late final _filledButtonThemeDataLight = FilledButtonThemeData(
    style: FilledButton.styleFrom(
      shape: _noBorder,
    ),
  );
  late final _filledButtonThemeDataDark = FilledButtonThemeData(
    style: FilledButton.styleFrom(
      shape: _noBorder,
    ),
  );

  // Filled Button Theme Data End

  // Outlined Button Theme Data

  late final _outlinedButtonThemeDataLight = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: _noBorder,
    ),
  );
  late final _outlinedButtonThemeDataDark = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: _noBorder,
    ),
  );

  // Outlined Button Theme Data End

  // Text Button Theme Data

  late final _textButtonThemeDataLight = TextButtonThemeData(
    style: TextButton.styleFrom(
      shape: _noBorder,
    ),
  );
  late final _textButtonThemeDataDark = TextButtonThemeData(
    style: TextButton.styleFrom(
      shape: _noBorder,
    ),
  );

  // Text Button Theme Data End

  // Icon Button Theme Data

  late final _iconButtonThemeDataLight = IconButtonThemeData(
    style: IconButton.styleFrom(
      shape: _noBorder,
      backgroundColor: _colorSchemeLight.primary,
      foregroundColor: _colorSchemeLight.onPrimary,
    ),
  );
  late final _iconButtonThemeDataDark = IconButtonThemeData(
    style: IconButton.styleFrom(
      shape: _noBorder,
      backgroundColor: _colorSchemeDark.primary,
      foregroundColor: _colorSchemeDark.onPrimary,
    ),
  );

  // Icon Button Theme Data End

  // Input Theme Data Start

  late final _textFieldThemeDataLight = InputDecorationTheme(
    filled: true,
    floatingLabelBehavior: FloatingLabelBehavior.never,
    hintStyle: TextStyle(
      fontSize: 14,
      color: _colorSchemeLight.onSurface.withValues(alpha: 0.38),
    ),
    border: const OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.zero,
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: _colorSchemeLight.primary,
        width: 1.5,
      ),
      borderRadius: BorderRadius.zero,
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: _colorSchemeLight.error,
        width: 1,
      ),
      borderRadius: BorderRadius.zero,
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: _colorSchemeLight.error,
        width: 1,
      ),
      borderRadius: BorderRadius.zero,
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: _colorSchemeLight.outline,
        width: 1,
      ),
      borderRadius: BorderRadius.zero,
    ),
    disabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.transparent,
        width: 0,
      ),
      borderRadius: BorderRadius.zero,
    ),
  );

  late final _textFieldThemeDataDark = InputDecorationTheme(
    filled: true,
    floatingLabelBehavior: FloatingLabelBehavior.never,
    hintStyle: TextStyle(
      fontSize: 14,
      color: _colorSchemeDark.onSurface.withValues(alpha: 0.38),
    ),
    border: const OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.zero,
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: _colorSchemeDark.primary,
        width: 1.5,
      ),
      borderRadius: BorderRadius.zero,
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: _colorSchemeDark.error,
        width: 1,
      ),
      borderRadius: BorderRadius.zero,
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: _colorSchemeDark.error,
        width: 1,
      ),
      borderRadius: BorderRadius.zero,
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: _colorSchemeDark.outline,
        width: 1,
      ),
      borderRadius: BorderRadius.zero,
    ),
    disabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.transparent,
        width: 0,
      ),
      borderRadius: BorderRadius.zero,
    ),
  );

  // Input Theme Data End

  // // Menu Theme Data Start

  // late final _menuThemeDataLight = const MenuThemeData();

  // late final _menuThemeDataDark = const MenuThemeData();

  // // Menu Theme Data End

  // Dropdown Menu Theme Data Start

  late final _dropdownMenuThemeDataLight = DropdownMenuThemeData(
    inputDecorationTheme: _textFieldThemeDataLight,
  );

  late final _dropdownMenuThemeDataDark = DropdownMenuThemeData(
    inputDecorationTheme: _textFieldThemeDataDark,
  );

  // Dropdown Menu Theme Data End

  // Popup Menu  Theme Data Start

  late final _popupMenuThemeDataLight = PopupMenuThemeData(
    shape: _noBorder,
    position: PopupMenuPosition.under,
    elevation: 4,
  );

  late final _popupMenuThemeDataDark = PopupMenuThemeData(
    shape: _noBorder,
    position: PopupMenuPosition.under,
    elevation: 4,
  );

  // Popup Menu Theme Data End

  late final ThemeData lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: Colors.grey.shade300,
    colorScheme: _colorSchemeLight,
    textTheme: _textThemeLight,
    filledButtonTheme: _filledButtonThemeDataLight,
    outlinedButtonTheme: _outlinedButtonThemeDataLight,
    textButtonTheme: _textButtonThemeDataLight,
    iconButtonTheme: _iconButtonThemeDataLight,
    inputDecorationTheme: _textFieldThemeDataLight,
    // menuTheme: _menuThemeDataLight,
    dropdownMenuTheme: _dropdownMenuThemeDataLight,
    popupMenuTheme: _popupMenuThemeDataLight,
  );

  late final ThemeData darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Colors.grey.shade900,
    colorScheme: _colorSchemeDark,
    textTheme: _textThemeDark,
    filledButtonTheme: _filledButtonThemeDataDark,
    outlinedButtonTheme: _outlinedButtonThemeDataDark,
    textButtonTheme: _textButtonThemeDataDark,
    iconButtonTheme: _iconButtonThemeDataDark,
    inputDecorationTheme: _textFieldThemeDataDark,
    // menuTheme: _menuThemeDataDark,
    dropdownMenuTheme: _dropdownMenuThemeDataDark,
    popupMenuTheme: _popupMenuThemeDataDark,
  );
}
