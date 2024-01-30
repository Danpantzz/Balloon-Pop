import 'package:flutter/material.dart';

import 'snack_bar.dart';

void showErrorSnackbar(String errorMessage, {SnackBarAction? action}) {
  final messenger = scaffoldMessengerKey.currentState;
  final text = RichText(
    text: TextSpan(
      children: [
        const TextSpan(
          text: 'Error: ',
          style: TextStyle(color: Color(0xFFd10841), fontWeight: FontWeight.bold),
        ),
        TextSpan(
          text: errorMessage,
          style: const TextStyle(
            color: Color(0xee352b42),
          ),
        ),
      ],
    ),
  );

  final duration = Duration(milliseconds: errorMessage.characters.length * 120);

  messenger
    ?..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: text,
        margin: const EdgeInsets.only(bottom: 30, left: 24, right: 24),
        behavior: SnackBarBehavior.floating,
        duration: duration,
        backgroundColor: Color(0xffffffd1),
        dismissDirection: DismissDirection.horizontal,
        action: action,
      ),
    );
}