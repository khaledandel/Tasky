import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  useMaterial3: true,
  brightness: .light,

  colorScheme: ColorScheme.light(
    primaryContainer: Color(0xFFFFFFFF),
    secondary: Color(0xFF161F1B),
  ),

  scaffoldBackgroundColor: Color(0xFFF6F7F9),
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(color: Color(0xFF161F1B)),

    backgroundColor: Color(0xFFF6F7F9),
    titleTextStyle: TextStyle(
      color: Color(0xFF161F1B),
      fontSize: 24,
      fontWeight: .w400,
    ),
    centerTitle: true,
  ),

  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF14A662),
    foregroundColor: Color(0xFFFFFFFF),
    extendedTextStyle: TextStyle(fontSize: 14, fontWeight: .w500),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(Color(0xFF14A662)),
      foregroundColor: WidgetStateProperty.all(Color(0xFFFFFFFF)),
      textStyle: WidgetStateProperty.all(
        TextStyle(fontSize: 14, fontWeight: .w500),
      ),
    ),
  ),

  switchTheme: SwitchThemeData(
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Color(0xFF14A662);
      } else {
        return Colors.white;
      }
    }),

    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.white;
      } else {
        return Color(0xFF9E9E9E);
      }
    }),

    trackOutlineColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.transparent;
      } else {
        return Color(0xFF9E9E9E);
      }
    }),

    trackOutlineWidth: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return 0;
      } else {
        return 2;
      }
    }),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Color(0xFFFFFFFF),
    hintStyle: TextStyle(color: Color(0xFF9E9E9E)),
    focusColor: Color(0xFFD1DAD6),

    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Colors.red, width: 0.5),
    ),

    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Color(0xFFD1DAD6), width: 0.5),
    ),

    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Color(0xFFD1DAD6), width: 0.5),
    ),

    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Color(0xFFD1DAD6), width: 0.5),
    ),
  ),

  checkboxTheme: CheckboxThemeData(
    side: BorderSide(color: Color(0xFFD1DAD6), width: 2),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  ),

  textTheme: TextTheme(
    displaySmall: TextStyle(
      fontSize: 24,
      color: Color(0xFF161F1B),
      fontWeight: .w400,
    ),
    ///////////////////////////////////////////////
    displayMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w400,
      color: Color(0xFF161F1B),
    ),
    ///////////////////////////////////////////////
    displayLarge: TextStyle(
      fontSize: 32,
      color: Color(0xFF161F1B),
      fontWeight: .w400,
    ),
    ///////////////////////////////////////////////
    titleSmall: TextStyle(
      color: Color(0xFF3A4640),
      fontSize: 14,
      fontWeight: .w500,
    ),

    ///////////////////////////////////////////////
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Color(0xFF161F1B),
    ),
    /////////////////////////////////////////////////////////////////
    /// For Done Tasks
    ///
    titleLarge: TextStyle(
      color: Color(0xFF6A6A6A),
      fontSize: 16,
      fontWeight: .w400,
      overflow: .ellipsis,
      decoration: TextDecoration.lineThrough,
      decorationColor: Color(0xFF3A4640),
    ),

    /////////////////////////////////////////////////////////////////
    labelSmall: TextStyle(
      fontSize: 20,
      fontWeight: .w500,
      color: Color(0xFF161F1B),
    ),
    /////////////////////////////////////////////////////////////////
    labelMedium: TextStyle(color: Colors.black, fontSize: 16),
    /////////////////////////////////////////////////////////////////
    labelLarge: TextStyle(fontSize: 24, fontWeight: .w400, color: Colors.black),
  ),

  listTileTheme: ListTileThemeData(
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: .w500,
      color: Color(0xFF161F1B),
    ),
  ),

  dividerTheme: DividerThemeData(color: Color(0xFFD1DAD6), thickness: 1),

  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.black,
    selectionColor: Colors.white,
    selectionHandleColor: Colors.black,
  ),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    unselectedItemColor: Color(0xFF3A4640),
    selectedItemColor: Color(0xFF14A662),
    backgroundColor: Color(0xFFF6F7F9),
    type: BottomNavigationBarType.fixed,
  ),
  splashFactory: NoSplash.splashFactory,

  popupMenuTheme: PopupMenuThemeData(
    color: Color(0xFFF6F7F9),
    shape: RoundedRectangleBorder(borderRadius: .circular(16)),
    elevation: 2,
    shadowColor: Color(0xff15B86C),

    labelTextStyle: WidgetStateProperty.all(
      TextStyle(
        color: Color(0xFF161F1B),
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),
    ),
  ),
);
