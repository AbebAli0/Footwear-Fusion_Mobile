import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static bool isFocused = false;
  static _border([Color color = backgroundColor2]) => OutlineInputBorder(
        borderSide: BorderSide(color: color, width: 3),
        borderRadius: BorderRadius.circular(12),
      );
  static _borderError([Color color = alertColor]) => OutlineInputBorder(
        borderSide: BorderSide(color: color, width: 3),
        borderRadius: BorderRadius.circular(12),
      );
  static final darkMode = ThemeData.dark().copyWith(
    appBarTheme: const AppBarTheme(backgroundColor: backgroundColor2),
    scaffoldBackgroundColor: backgroundColor1,
    inputDecorationTheme: InputDecorationTheme(
        fillColor: backgroundColor2,
        filled: true,
        errorBorder: _borderError(),
        focusedBorder: _border(primaryColor),
        enabledBorder: InputBorder.none),
  );
}

double defaultMargin = 30.0;
const Color gradient1 = Color.fromRGBO(187, 63, 221, 1);
const Color gradient2 = Color.fromRGBO(251, 109, 169, 1);
const Color gradient3 = Color.fromRGBO(255, 159, 124, 1);
const Color primaryColor = Color(0xff6C5ECF);
const Color secondaryColor = Color(0xff38ABBE);
const Color alertColor = Color(0xffED6363);
const Color priceColor = Color(0xff2C96F1);
const Color backgroundColor1 = Color(0xff1F1D2B);
const Color backgroundColor2 = Color(0xff2B2937);
const Color backgroundColor3 = Color(0xff242231);
const Color backgroundColor4 = Color(0xff252836);
const Color backgroundColor5 = Color(0xff2B2844);
const Color primaryTextColor = Color(0xffF1F0F2);
const Color secondaryTextColor = Color(0xff999999);
const Color subtitleColor = Color(0xff504F5E);
const Color transparentColor = Colors.transparent;
const blackColor = Color(0xff2E2E2E);

TextStyle primaryTextStyle = GoogleFonts.poppins(
  color: primaryTextColor,
);

TextStyle secondaryTextStyle = GoogleFonts.poppins(
  color: secondaryTextColor,
);

TextStyle subtitleTextStyle = GoogleFonts.poppins(
  color: subtitleColor,
);

TextStyle priceTextStyle = GoogleFonts.poppins(
  color: priceColor,
);

TextStyle blackTextStyle = GoogleFonts.poppins(
  color: blackColor,
);

FontWeight light = FontWeight.w300;
FontWeight regular = FontWeight.w400;
FontWeight medium = FontWeight.w500;
FontWeight semiBold = FontWeight.w600;
FontWeight bold = FontWeight.w700;
