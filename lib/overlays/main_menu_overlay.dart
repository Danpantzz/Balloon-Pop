import 'package:daniel_mcerlean_project_3/src/games_services/games_services.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:games_services/games_services.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

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
    final gamesServicesController = context.watch<GamesServicesController?>();

    return WillPopScope(
      onWillPop: () {
        // confirmation screen added to exit app when back button is pressed
        if (game.overlays.activeOverlays.length > 1) {
          game.overlays.remove(game.overlays.activeOverlays.last);
          return Future.value(false);
        }

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
                  //game.startGame();
                  game.overlays.add('gameModesOverlay');
                },
                child: const Text('Game Modes'),
              ),
              // Leaderboard
              // ElevatedButton(
              //   onPressed: () async {
              //     gamesServicesController!.showLeaderboard();
              //   },
              //   child: const Text('Leaderboard'),
              // ),
              // Settings Button
              ElevatedButton(
                onPressed: () {
                  game.overlays.add('settingsOverlay');
                },
                child: const Text('Settings'),
              ),

              // Quit Button
              ElevatedButton(
                onPressed: () {
                  game.overlays.add('exitOverlay');
                },
                child: const Text('Quit Game'),
              ),
              const Gap(35),
            ],
          ),
        ),
      ),
    );
  }
}
