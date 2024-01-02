import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme(BuildContext context) {
  return ThemeData(
    primaryColor: const Color.fromARGB(255, 104, 174, 255),

    // text themes
    textTheme: TextTheme(
      titleLarge: GoogleFonts.rubikBubbles(
        textStyle: TextStyle(
          fontSize: MediaQuery.of(context).size.width / 6,
          color: Colors.white,
          // https://stackoverflow.com/questions/52146269/how-to-decorate-text-stroke-in-flutter
          shadows: const [
            Shadow(
                // bottomLeft
                offset: Offset(-1.5, -1.5),
                color: Colors.black),
            Shadow(
                // bottomRight
                offset: Offset(1.5, -1.5),
                color: Colors.black),
            Shadow(
                // topRight
                offset: Offset(1.5, 1.5),
                color: Colors.black),
            Shadow(
                // topLeft
                offset: Offset(-1.5, 1.5),
                color: Colors.black),
          ],
        ),
      ),
      titleMedium: GoogleFonts.rubikBubbles(
        textStyle: TextStyle(
          fontSize: MediaQuery.of(context).size.width / 8,
          color: Colors.grey,
          // https://stackoverflow.com/questions/52146269/how-to-decorate-text-stroke-in-flutter
          shadows: const [
            Shadow(
                // bottomLeft
                offset: Offset(-1.5, -1.5),
                color: Colors.black),
            Shadow(
                // bottomRight
                offset: Offset(1.5, -1.5),
                color: Colors.black),
            Shadow(
                // topRight
                offset: Offset(1.5, 1.5),
                color: Colors.black),
            Shadow(
                // topLeft
                offset: Offset(-1.5, 1.5),
                color: Colors.black),
          ],
        ),
      ),
      titleSmall: GoogleFonts.rubikBubbles(
        textStyle: TextStyle(
          fontSize: MediaQuery.of(context).size.width / 15,
          color: Colors.grey,
          // https://stackoverflow.com/questions/52146269/how-to-decorate-text-stroke-in-flutter
          shadows: const [
            Shadow(
                // bottomLeft
                offset: Offset(-1.5, -1.5),
                color: Colors.black),
            Shadow(
                // bottomRight
                offset: Offset(1.5, -1.5),
                color: Colors.black),
            Shadow(
                // topRight
                offset: Offset(1.5, 1.5),
                color: Colors.black),
            Shadow(
                // topLeft
                offset: Offset(-1.5, 1.5),
                color: Colors.black),
          ],
        ),
      ),
      displayLarge: GoogleFonts.rubikBubbles(
        textStyle: TextStyle(
          fontSize: MediaQuery.of(context).size.width / 12,
          color: Colors.white,
          // https://stackoverflow.com/questions/52146269/how-to-decorate-text-stroke-in-flutter
          shadows: const [
            Shadow(
                // bottomLeft
                offset: Offset(-1.5, -1.5),
                color: Colors.black),
            Shadow(
                // bottomRight
                offset: Offset(1.5, -1.5),
                color: Colors.black),
            Shadow(
                // topRight
                offset: Offset(1.5, 1.5),
                color: Colors.black),
            Shadow(
                // topLeft
                offset: Offset(-1.5, 1.5),
                color: Colors.black),
          ],
        ),
      ),
      displayMedium: GoogleFonts.rubikBubbles(
        textStyle: TextStyle(
          fontSize: MediaQuery.of(context).size.width / 18,
          color: Colors.white,
          // https://stackoverflow.com/questions/52146269/how-to-decorate-text-stroke-in-flutter
          shadows: const [
            Shadow(
                // bottomLeft
                offset: Offset(-1.5, -1.5),
                color: Colors.black),
            Shadow(
                // bottomRight
                offset: Offset(1.5, -1.5),
                color: Colors.black),
            Shadow(
                // topRight
                offset: Offset(1.5, 1.5),
                color: Colors.black),
            Shadow(
                // topLeft
                offset: Offset(-1.5, 1.5),
                color: Colors.black),
          ],
        ),
      ),
      displaySmall: GoogleFonts.rubikBubbles(
        textStyle: TextStyle(
          fontSize: MediaQuery.of(context).size.width / 25,
          color: Colors.white,
          // https://stackoverflow.com/questions/52146269/how-to-decorate-text-stroke-in-flutter
          shadows: const [
            Shadow(
                // bottomLeft
                offset: Offset(-1.5, -1.5),
                color: Colors.black),
            Shadow(
                // bottomRight
                offset: Offset(1.5, -1.5),
                color: Colors.black),
            Shadow(
                // topRight
                offset: Offset(1.5, 1.5),
                color: Colors.black),
            Shadow(
                // topLeft
                offset: Offset(-1.5, 1.5),
                color: Colors.black),
          ],
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
              shadows: const [
                Shadow(
                    // bottomLeft
                    offset: Offset(-1.5, -1.5),
                    color: Colors.black),
                Shadow(
                    // bottomRight
                    offset: Offset(1.5, -1.5),
                    color: Colors.black),
                Shadow(
                    // topRight
                    offset: Offset(1.5, 1.5),
                    color: Colors.black),
                Shadow(
                    // topLeft
                    offset: Offset(-1.5, 1.5),
                    color: Colors.black),
              ],
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
        backgroundColor: const MaterialStatePropertyAll(Color(0xFF0A2472)),
      ),
    ),

    // slider theme
    sliderTheme: const SliderThemeData(
      activeTrackColor: Color(0xFF0A2472),
      thumbColor: Color(0xFF0A2472),
      inactiveTrackColor: Colors.grey,
    ),
    switchTheme: const SwitchThemeData(
      thumbColor: MaterialStatePropertyAll(Color(0xFF0A2472)),
    ),
  );
}
