import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../game/balloon_pop.dart';

///
/// Main Menu Overlay is the page that displays on startup.
/// Contains:
///   Play game button,
///   Settings button,
///   Instructions button
///
class MainMenuOverlay extends StatefulWidget {
  const MainMenuOverlay(this.game, {super.key});

  final Game game;

  @override
  State<MainMenuOverlay> createState() => _MainMenuOverlayState();
}

class _MainMenuOverlayState extends State<MainMenuOverlay> {
  @override
  Widget build(BuildContext context) {
    // get reference to Flame game
    BalloonPop game = widget.game as BalloonPop;

    return WillPopScope(
      onWillPop: () {
        // confirmation screen added to exit app when back button is pressed
        game.overlays.add('exitOverlay');
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Gap(50),

              // App Title
              Text(
                'BALLOON POP!',
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const Gap(90),

              // Start Game Button
              ElevatedButton(
                onPressed: () async {
                  game.startGame();
                },
                child: const Text('Start Game'),
              ),

              // Settings Button
              ElevatedButton(
                onPressed: () {
                  game.overlays.add('settingsOverlay');
                },
                child: const Text('Settings'),
              ),

              // InstructionsButton
              ElevatedButton(
                onPressed: () {
                  game.overlays.add('instructionsOverlay');
                },
                child: const Text('Instructions'),
              ),
              const Gap(35),
            ],
          ),
        ),
      ),
    );
  }
}
