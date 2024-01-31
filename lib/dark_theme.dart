import 'package:daniel_mcerlean_project_3/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData darkTheme(BuildContext context) {
  return ThemeData(
    primaryColor: darkColor,

    // text themes
    textTheme: TextTheme(
      titleLarge: GoogleFonts.rubikBubbles(
        textStyle: TextStyle(
          fontSize: MediaQuery.of(context).size.width / 6,
          color: Color.fromARGB(255, 180, 180, 180),
          // https://stackoverflow.com/questions/52146269/how-to-decorate-text-stroke-in-flutter
          shadows: shadows,
        ),
      ),
      titleMedium: GoogleFonts.rubikBubbles(
        textStyle: TextStyle(
          fontSize: MediaQuery.of(context).size.width / 8,
          color: Colors.grey,
          // https://stackoverflow.com/questions/52146269/how-to-decorate-text-stroke-in-flutter
          shadows: shadows,
        ),
      ),
      titleSmall: GoogleFonts.rubikBubbles(
        textStyle: TextStyle(
          fontSize: MediaQuery.of(context).size.width / 15,
          color: Colors.grey,
          // https://stackoverflow.com/questions/52146269/how-to-decorate-text-stroke-in-flutter
          shadows: shadows,
        ),
      ),
      displayLarge: GoogleFonts.rubikBubbles(
        textStyle: TextStyle(
          fontSize: MediaQuery.of(context).size.width / 12,
          color: Colors.white,
          // https://stackoverflow.com/questions/52146269/how-to-decorate-text-stroke-in-flutter
          shadows: shadows,
        ),
      ),
      displayMedium: GoogleFonts.rubikBubbles(
        textStyle: TextStyle(
          fontSize: MediaQuery.of(context).size.width / 18,
          color: Colors.white,
          // https://stackoverflow.com/questions/52146269/how-to-decorate-text-stroke-in-flutter
          shadows: shadows,
        ),
      ),
      displaySmall: GoogleFonts.rubikBubbles(
        textStyle: TextStyle(
          fontSize: MediaQuery.of(context).size.width / 25,
          color: Colors.white,
          // https://stackoverflow.com/questions/52146269/how-to-decorate-text-stroke-in-flutter
          shadows: shadows,
        ),
      ),
    ),

    // button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStatePropertyAll(
          GoogleFonts.rubikBubbles(
            textStyle: TextStyle(
              fontSize: MediaQuery.of(context).size.width / 12,
              shadows: shadows,
            ),
          ),
        ),
        minimumSize: MaterialStatePropertyAll(
          Size(
            MediaQuery.of(context).size.width / 1.6,
            MediaQuery.of(context).size.height / 15,
          ),
        ),
        padding: const MaterialStatePropertyAll(EdgeInsets.all(8.0)),
        backgroundColor: MaterialStatePropertyAll(darkButtonColor),
      ),
    ),

    // slider theme
    sliderTheme: SliderThemeData(
      activeTrackColor: darkButtonColor,
      thumbColor: darkButtonColor,
      inactiveTrackColor: Colors.grey,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStatePropertyAll(darkButtonColor),
    ),
  );
}
