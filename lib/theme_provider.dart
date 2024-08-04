import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;

  // Define the custom light and dark themes
  final ThemeData _lightTheme = ThemeData.light().copyWith(
      // Add your light theme customizations here if needed
      );

  final ThemeData _darkTheme = ThemeData.dark().copyWith(
    primaryColor: Colors.blue, // Primary color for elements like buttons
    backgroundColor: Color(0xFF121212),
    scaffoldBackgroundColor: Color(0xFF121212),
    cardColor: Color(0xFF1E1E1E),
    errorColor: Color(0xFFCF6679),
    textTheme: TextTheme(
      headline1: TextStyle(color: Colors.white),
      headline2: TextStyle(color: Colors.white),
      headline3: TextStyle(color: Colors.white),
      headline4: TextStyle(color: Colors.white),
      headline5: TextStyle(color: Colors.white),
      headline6: TextStyle(color: Colors.white),
      subtitle1: TextStyle(color: Colors.white),
      subtitle2: TextStyle(color: Colors.white),
      bodyText1: TextStyle(color: Colors.white),
      bodyText2: TextStyle(color: Colors.white),
      button: TextStyle(color: Colors.blue), // Text for buttons
      caption: TextStyle(color: Colors.white),
      overline: TextStyle(color: Colors.white),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.blue, // Button color
      textTheme: ButtonTextTheme.primary, // Ensures text color is blue
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue, // Text color for dark theme
      ),
    ),
    appBarTheme: AppBarTheme(
      color: Colors.black,
      iconTheme: IconThemeData(color: Colors.white),
      toolbarTextStyle: TextTheme(
        headline6: TextStyle(color: Colors.white, fontSize: 20),
      ).bodyText2,
      titleTextStyle: TextTheme(
        headline6: TextStyle(color: Colors.white, fontSize: 20),
      ).headline6,
    ),
  );

  ThemeData get currentTheme => _isDarkMode ? _darkTheme : _lightTheme;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}
