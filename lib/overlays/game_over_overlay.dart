import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../game/balloon_pop.dart';

///
/// GameOver Screen appears when the player runs out of lives
/// Contains:
///   details about the players score
///   Play Again Button
///   Go Home Button
///
class GameOverOverlay extends StatefulWidget {
  const GameOverOverlay(this.game, {super.key});

  final Game game;

  @override
  State<GameOverOverlay> createState() => _GameOverOverlayState();
}

class _GameOverOverlayState extends State<GameOverOverlay> {
  @override
  Widget build(BuildContext context) {
    BalloonPop game = widget.game as BalloonPop;

    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          alignment: Alignment.bottomCenter,
          width: game.size.x / 1.3,
          height: game.size.y / 1.3,
          padding: const EdgeInsets.all(5.0),
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
              // Game Over Text
              Text(
                'Game Over!',
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
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
              // Play Again Button (resets game, and removes this overlay)
              ElevatedButton(
                onPressed: () async {
                  game.resetGame();
                },
                child: const Text('Play again'),
              ),
              // Go Home Button (ends the game, and displays the mainMenuOverlay)
              ElevatedButton(
                onPressed: () async {
                  game.endGame();
                },
                child: const Text('Go Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
