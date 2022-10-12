import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:instameal/views/nav_screen/home.dart';

class CustomTheme {
  static double borderRadius = 20;

  // _____ COLOR THEME _____
  static const bgColor = Color(0xffA0B647); //#F5F5F5
  static const bgColor2 = Color(0xffF5F5F5); //#F5F5F5
  static const primaryColor = Color(0xff00314a);
  static const secondaryColor = Color(0xffc79937);
  static const lightColor = Color(0xffc79937);
  static const darkColor = Color(0xffc79937); //580980
  static const shadowColor = Color(0xff3939391A); //580980
  static const grey = Color.fromARGB(255, 211, 208, 208); //dc281c
  static const red = Color(0xffdc281c); //dc281c
  static const shadowColor2 = Color.fromARGB(120, 160, 182, 71);

  static Widget loader() => Center(
          child: CircularProgressIndicator(
        backgroundColor: secondaryColor,
        color: primaryColor,
      ));
  logout(context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Home()));
  }
  // _______________________

  static ThemeData themedata = ThemeData(
    // _____ COLOR THEME _____
    brightness: Brightness.light,
    backgroundColor: Colors.white,
    scaffoldBackgroundColor: const Color.fromARGB(225, 234, 239, 250),
    primaryColor: const Color.fromARGB(255, 0, 3, 157),
    // highlightColor: Color.fromARGB(255, 121, 121, 130),
    cardColor: Colors.white,
    errorColor: const Color.fromARGB(255, 221, 0, 0),
    //hintColor: Colors.green,
    // _______________________

    // _____ TEXT THEME _____
    // fontFamily:GoogleFonts.comfortaa(fon),
    textTheme: TextTheme(
      headline1: GoogleFonts.comfortaa(
          color: Colors.white, fontWeight: FontWeight.bold),
      headline2: GoogleFonts.comfortaa(
          color: Colors.white, fontWeight: FontWeight.bold),
      headline3: GoogleFonts.comfortaa(
          color: Colors.white, fontWeight: FontWeight.bold),
      headline4: GoogleFonts.comfortaa(
        fontWeight: FontWeight.w500,
        color: bgColor,
        letterSpacing: -1.5,
      ),
      headline6: GoogleFonts.comfortaa(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      subtitle1: GoogleFonts.comfortaa(
          fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
      bodyText1: GoogleFonts.comfortaa(color: Colors.black),

      // bodyText2: GoogleFonts.rubik(color: Colors.black),
      // bodyLarge:
      //     GoogleFonts.rubik(color: Colors.black, fontWeight: FontWeight.bold),
      // bodyMedium: GoogleFonts.rubik(color: Colors.black),
      // bodySmall: GoogleFonts.rubik(
      //   color: Colors.black,
      // ),
      button: GoogleFonts.comfortaa(
          fontSize: 18, fontWeight: FontWeight.w500, letterSpacing: 0.1),
    ),
    // _______________________

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      showUnselectedLabels: true,
      selectedItemColor: bgColor,
      unselectedItemColor: bgColor,
      selectedIconTheme: IconThemeData(size: 32),
      unselectedIconTheme: IconThemeData(color: bgColor, size: 32),
      selectedLabelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
      unselectedLabelStyle:
          TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
    ),
    // textButtonTheme: TextButtonThemeData(
    //   style: TextButton.styleFrom(
    // minimumSize: const Size(260, 49),
    // primary: bgColor,
    // backgroundColor: bgColor,
    //   ),
    // ),
    cardTheme: CardTheme(
      elevation: 0.1,
      margin: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.only(left: 8.0, bottom: 8.0, top: 0.0),
      fillColor: const Color.fromARGB(255, 245, 245, 245),
      focusColor: Colors.transparent,
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(color: bgColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(color: bgColor),
      ),
      labelStyle: const TextStyle(
        color: bgColor,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      floatingLabelStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: bgColor,
      ),
    ),
  );
}
