import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color.fromRGBO(28, 80, 143, 1);
  static const Color backgroundColor = Colors.white;
  static const Color textColor = Colors.black87;
  static const Color hintTextColor = Colors.grey;
  static const Color inputFillColor = Color(0xFFF2F2F2);

  static const double defaultSpace = 10.0;
  static const double defaultBorderRadius = 10.0;
  static const double inputBorderRadius = 8.0;
  static const Color defaultBorderInputColor =
      Color.fromRGBO(212, 212, 212, 0.7);

  // static TextStyle defaultTextStyle = GoogleFonts.montserrat(
  //   fontSize: 14,
  //   color: textColor,
  // );
  static TextStyle defaultTextStyle = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 14,
    color: textColor,
  );

  static final ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    textTheme: GoogleFonts.montserratTextTheme(),
    fontFamily: 'Montserrat',
    appBarTheme: AppBarTheme(
      backgroundColor: backgroundColor,
      elevation: 0,
      titleTextStyle: defaultTextStyle.copyWith(
        fontSize: 18,
      ),
      iconTheme: IconThemeData(color: textColor),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: inputFillColor,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 8.0,
      ),
      hintStyle: TextStyle(color: hintTextColor, fontSize: 14.0),
      labelStyle: TextStyle(fontSize: 14.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(inputBorderRadius + 4.0),
        borderSide: BorderSide(color: defaultBorderInputColor, width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: defaultBorderInputColor, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: defaultBorderInputColor, width: 1.5),
      ),
    ),
    // textSelectionTheme: TextSelectionThemeData(
    //   cursorColor: primaryColor,
    // ),
  );
}
