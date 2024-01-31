import 'package:flutter/material.dart';

Color lightColor = const Color.fromARGB(255, 104, 174, 255);
Color darkColor = const Color.fromARGB(255, 92, 39, 176);

Color lightButtonColor = const Color(0xFF0A2472);
Color darkButtonColor = Colors.white;

Color lightContainerColor = Colors.white;
Color darkContainerColor = const Color.fromARGB(255, 73, 73, 73);

List<Shadow> shadows = const [
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
];
