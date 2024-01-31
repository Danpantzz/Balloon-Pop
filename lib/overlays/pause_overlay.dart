import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../game/balloon_pop.dart';

///
/// Pause Menu displays when pressing the pause button in gameOverlay
/// Contains:
///   information about user's score
///   Settings Button
///   Restart Button
///   Home Button
///   Resume Button
///
class PauseOverlay extends StatefulWidget {
  const PauseOverlay(this.game, {super.key});

  final Game game;

  @override
  State<PauseOverlay> createState() => _PauseOverlayState();
}

class _PauseOverlayState extends State<PauseOverlay> {
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
        child: Center(
          child: Container(
            alignment: Alignment.bottomCenter,
            width: game.size.x / 1.3,
            height: game.size.y / 1.3,
            padding: const EdgeInsets.only(right: 5.0, left: 5.0, bottom: 5.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black),
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Paused title
                    Text(
                      'Paused',
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                    // Settings gear in topRight corner of container.
                    // Leads to the settingsOverlay
                    IconButton(
                      alignment: Alignment.topRight,
                      padding: const EdgeInsets.only(left: 20.0),
                      color: const Color.fromARGB(255, 77, 77, 77),
                      icon: const Icon(Icons.settings),
                      iconSize: 48,
                      onPressed: () {
                        game.overlays.add('settingsOverlay');
                      },
                      tooltip: 'Settings',
                    ),
                  ],
                ),
                // Display the users score.
                // ValueListenableBuilder allows this to change as score changes,
                // though the score won't change while the game is paused
                ValueListenableBuilder(
                  valueListenable: game.gameManager.score,
                  builder: (context, value, child) {
                    return Text(
                      'Your score is:\n$value',
                      style: Theme.of(context).textTheme.titleSmall,
                      textAlign: TextAlign.center,
                    );
                  },
                ),
                // Restart Button (restarts the game)
                ElevatedButton(
                  onPressed: () async {
                    game.resetGame();
                  },
                  child: const Text('Restart'),
                ),
                // Go Home Button (ends the game and goes to mainMenuOverlay)
                ElevatedButton(
                  onPressed: () async {
                    game.endGame();
                  },
                  child: const Text('Go Home'),
                ),
                // Resume Button (unpauses the game, removing this overlay)
                ElevatedButton(
                  onPressed: () async {
                    game.pause();
                  },
                  child: const Text('Resume'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
