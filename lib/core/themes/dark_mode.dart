import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  useMaterial3: true,
  brightness: .dark,

  colorScheme: ColorScheme.dark(
    primaryContainer: Color(0xFF282828),
    secondary: Color(0xFFFFFCFC),
  ),

  scaffoldBackgroundColor: Color(0xFF181818),
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(color: Color(0xFFFFFCFC)),

    backgroundColor: Color(0xFF181818),
    titleTextStyle: TextStyle(color: Color(0xFFFFFCFC), fontSize: 24),
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
        return Color(0xFF15B86C);
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
    fillColor: Color(0xff282828),
    hintStyle: TextStyle(color: Color(0xff6D6D6D)),

    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Colors.red, width: 0.5),
    ),

    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    ),
  ),

  checkboxTheme: CheckboxThemeData(
    side: BorderSide(color: Color(0xFF6E6E6E), width: 2),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  ),
  //////////////////////////////////////////
  textTheme: TextTheme(
    displaySmall: TextStyle(
      fontSize: 24,
      color: Color(0xFFFFFCFC),
      fontWeight: .w400,
    ),

    //////////////////////////////////////////
    displayMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w400,
      color: Color(0xFFFFFFFF),
    ),
    //////////////////////////////////////////
    displayLarge: TextStyle(
      fontSize: 32,
      color: Color(0xFFFFFCFC),
      fontWeight: .w400,
    ),
    //////////////////////////////////////////
    titleSmall: TextStyle(
      color: Color(0xFFC6C6C6),
      fontSize: 14,
      fontWeight: .w400,
    ),

    //////////////////////////////////////////
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Color(0xFFFFFCFC),
    ),
    //////////////////////////////////////////
    /// For Done Tasks
    ///
    titleLarge: TextStyle(
      color: Color(0xFFA0A0A0),
      fontSize: 16,
      fontWeight: .w400,
      overflow: .ellipsis,
      decoration: TextDecoration.lineThrough,
      decorationColor: Color(0xFFA0A0A0),
    ),

    labelSmall: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w400,
      color: Color(0xFFFFFCFC),
    ),

    ////////////////////////////////////////////////////////////////
    labelMedium: TextStyle(color: Colors.white, fontSize: 16),
    ////////////////////////////////////////////////////////////////
    labelLarge: TextStyle(fontSize: 24, fontWeight: .w400, color: Colors.white),
  ),

  listTileTheme: ListTileThemeData(
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w400,
      color: Color(0xFFFFFCFC),
    ),
  ),

  dividerTheme: DividerThemeData(color: Color(0xFF6E6E6E), thickness: 1),

  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.white,
    selectionColor: Colors.black,
    selectionHandleColor: Colors.white,
  ),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    unselectedItemColor: Color(0xFFC6C6C6),
    selectedItemColor: Color(0xff15B86C),
    backgroundColor: Color(0xFF181818),
    type: BottomNavigationBarType.fixed,
  ),
  splashFactory: NoSplash.splashFactory,

  popupMenuTheme: PopupMenuThemeData(
    color: Color(0xFF181818),
    shape: RoundedRectangleBorder(
      side: BorderSide(color: Color(0xff15B86C), width: 1),
      borderRadius: .circular(16),
    ),
    elevation: 2,
    shadowColor: Color(0xff15B86C),

    labelTextStyle: WidgetStateProperty.all(
      TextStyle(
        color: Color(0xFFFFFCFC),
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),
    ),
  ),
);
