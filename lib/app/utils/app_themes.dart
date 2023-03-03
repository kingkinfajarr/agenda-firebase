import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemes {
  static const Color scaffoldColor = Color(0xFFFEFEFE);
  static const Color orange = Color(0xFFFAB400);
  static const Color darkGreen = Color(0xFF02170E);
  static const Color greenGrey = Color(0xFFD6FFEE);
  static const Color white = Colors.white;
  static const Color lightGrey = Color(0xFFF6F7FB);
  static const Color grey = Color(0xFF666666);
  static const Color black = Color(0xFF111111);
  static const Color red = Colors.red;
  static const Color green = Colors.green;

  static TextStyle headline1 = TextStyle(
    fontFamily: GoogleFonts.poppins().fontFamily,
    fontSize: 26,
    fontWeight: FontWeight.w700,
    color: black,
  );

  static TextStyle headline2 = TextStyle(
    fontFamily: GoogleFonts.poppins().fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: black,
  );

  static TextStyle headline3 = TextStyle(
    fontFamily: GoogleFonts.poppins().fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: black,
  );

  static TextStyle text1 = TextStyle(
    fontFamily: GoogleFonts.poppins().fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: black,
  );

  static TextStyle text2 = TextStyle(
    fontFamily: GoogleFonts.poppins().fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: black,
  );

  static TextStyle subText1 = TextStyle(
    fontFamily: GoogleFonts.poppins().fontFamily,
    fontSize: 10,
    fontWeight: FontWeight.w300,
    color: black,
  );
}
