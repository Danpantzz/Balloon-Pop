import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../game/balloon_pop.dart';

///
/// Exit Overlay displays when the user presses the back button on the mainMenuOverlay
/// note: I attempted to use an AlertDialogue on pressing the back button,
///       but it seems it doesn't work normally with overlays.
///
class ExitOverlay extends StatefulWidget {
  const ExitOverlay(this.game, {super.key});

  final Game game;

  @override
  State<ExitOverlay> createState() => _ExitOverlayState();
}

class _ExitOverlayState extends State<ExitOverlay> {
  @override
  Widget build(BuildContext context) {
    BalloonPop game = widget.game as BalloonPop;

    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          alignment: Alignment.bottomCenter,
          width: game.size.x / 1.3,
          height: game.size.y / 2,
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
              // Ask if user wants to exit
              Text(
                'Are you sure you want to quit?',
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // No Button (remove this overlay and goes back to mainMenuOverlay)
                  ElevatedButton(
                    onPressed: () {
                      game.overlays.remove('exitOverlay');
                    },
                    style: ButtonStyle(
                      minimumSize: MaterialStatePropertyAll(
                        Size(
                          MediaQuery.of(context).size.width / 5,
                          MediaQuery.of(context).size.height / 20,
                        ),
                      ),
                    ),
                    child: const Text('No'),
                  ),
                  // Yes Button (quits the app)
                  ElevatedButton(
                    onPressed: () {
                      SystemNavigator.pop();
                    },
                    style: ButtonStyle(
                      minimumSize: MaterialStatePropertyAll(
                        Size(
                          MediaQuery.of(context).size.width / 5,
                          MediaQuery.of(context).size.height / 20,
                        ),
                      ),
                    ),
                    child: const Text('Yes'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
