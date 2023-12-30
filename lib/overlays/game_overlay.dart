import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../game/balloon_pop.dart';

///
/// Game Overlay is the UI that displays while playing
/// Contains:
///   Score display
///   Lives left
///   Pause Button
///
class GameOverlay extends StatefulWidget {
  const GameOverlay(this.game, {super.key});

  final Game game;

  @override
  State<GameOverlay> createState() => _GameOverlayState();
}

class _GameOverlayState extends State<GameOverlay> {
  // Height of the heart images
  double heartHeight = 25;

  @override
  Widget build(BuildContext context) {
    BalloonPop game = widget.game as BalloonPop;

    return WillPopScope(
      onWillPop: () {
        game.pause();
        return Future.value(false);
      },
      child: Material(
        color: Colors.transparent,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: game.size.x,
              // Container should be 50 pixels big, plus the size of the safeArea so it is not blocked
              height: 50 + MediaQuery.of(context).padding.top,
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              color: const Color.fromARGB(255, 255, 243, 131),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // ValueListenableBuilder changes the score value in real-time, without setState
                  ValueListenableBuilder(
                    valueListenable: game.gameManager.score,
                    builder: (context, value, child) {
                      return Text(
                        'Score: $value',
                        style: Theme.of(context).textTheme.displayMedium,
                      );
                    },
                  ),
                  // Stack is used to display 5 empty heart containers underneath the
                  // filled hearts that are generated depending on life left
                  Stack(
                    children: [
                      // Row of 5 empty heart containers
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 1, right: 1),
                            child: Image.asset(
                              'assets/images/heart_empty.png',
                              height: heartHeight,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 1, right: 1),
                            child: Image.asset(
                              'assets/images/heart_empty.png',
                              height: heartHeight,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 1, right: 1),
                            child: Image.asset(
                              'assets/images/heart_empty.png',
                              height: heartHeight,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 1, right: 1),
                            child: Image.asset(
                              'assets/images/heart_empty.png',
                              height: heartHeight,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 1, right: 1),
                            child: Image.asset(
                              'assets/images/heart_empty.png',
                              height: heartHeight,
                            ),
                          ),
                        ],
                      ),
                      // Create row of filled hearts depending on life remaining
                      ValueListenableBuilder(
                        valueListenable: game.gameManager.life,
                        builder: (context, value, child) {
                          // empty list of widgets
                          List<Widget> list = [];
                          for (int i = 0; i < value; i++) {
                            // for every life remaining, add a heart_full image to list
                            list.add(
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 1, right: 1),
                                child: Image.asset(
                                  'assets/images/heart_full.png',
                                  height: heartHeight,
                                ),
                              ),
                            );
                          }
                          // add list to Row and return
                          return Row(
                            children: list,
                          );
                        },
                      ),
                    ],
                  ),
                  // Pause button (pauses the game, which then displays pauseOverlay)
                  ElevatedButton(
                    onPressed: () {
                      game.pause();
                    },
                    style: ButtonStyle(
                      minimumSize: MaterialStatePropertyAll(
                        Size(
                          MediaQuery.of(context).size.height / 12,
                          MediaQuery.of(context).size.width / 15,
                        ),
                      ),
                      textStyle: MaterialStatePropertyAll(
                          Theme.of(context).textTheme.displaySmall),
                    ),
                    child: const Text("Pause"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
