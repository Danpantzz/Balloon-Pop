import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../game/balloon_pop.dart';

///
/// Instructions Page tells the player how to play
///
class InstructionsOverlay extends StatefulWidget {
  const InstructionsOverlay(this.game, {super.key});

  final Game game;

  @override
  State<InstructionsOverlay> createState() => _InstructionsOverlayState();
}

class _InstructionsOverlayState extends State<InstructionsOverlay> {
  @override
  Widget build(BuildContext context) {
    BalloonPop game = widget.game as BalloonPop;
    double balloonHeight = game.size.y / 6;

    return WillPopScope(
      onWillPop: () {
        game.overlays.remove('instructionsOverlay');
        return Future.value(false);
      },
      child: Material(
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
                // Expanded Widget contains SingleChildScrollView to prevent overflow
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Scrollbar(
                      interactive: true,
                      thumbVisibility: true,
                      trackVisibility: true,
                      child: SingleChildScrollView(
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              // Gameplay Instructions
                              Container(
                                padding: const EdgeInsets.all(8),
                                margin: const EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color.fromARGB(255, 255, 243, 131),
                                ),
                                child: Text(
                                  "Don't let the balloons reach the top!",
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.displayLarge,
                                ),
                              ),
                              // Green Balloon Instructions
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Image.asset(
                                    'assets/images/balloon_green.png',
                                    height: balloonHeight,
                                  ),
                                  SizedBox(
                                    width: game.size.x / 2,
                                    child: Text(
                                      '1 point\neasiest to pop',
                                      softWrap: true,
                                      textAlign: TextAlign.center,
                                      style:
                                          Theme.of(context).textTheme.titleSmall,
                                    ),
                                  ),
                                ],
                              ),
                              // Yellow Balloon Instructions
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    width: game.size.x / 2,
                                    child: Text(
                                      '3 points\n2 taps to pop',
                                      softWrap: true,
                                      textAlign: TextAlign.center,
                                      style:
                                          Theme.of(context).textTheme.titleSmall,
                                    ),
                                  ),
                                  Image.asset(
                                    'assets/images/balloon_yellow.png',
                                    height: balloonHeight,
                                  ),
                                ],
                              ),
                              // Red Balloon Instructions
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Image.asset(
                                    'assets/images/balloon_red.png',
                                    height: balloonHeight,
                                  ),
                                  SizedBox(
                                    width: game.size.x / 2,
                                    child: Text(
                                      '5 points\nvery fast',
                                      softWrap: true,
                                      textAlign: TextAlign.center,
                                      style:
                                          Theme.of(context).textTheme.titleSmall,
                                    ),
                                  ),
                                ],
                              ),
                              // Purple Balloon Instructions
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    width: game.size.x / 2,
                                    child: Text(
                                      '20 points\n5 taps to pop',
                                      softWrap: true,
                                      textAlign: TextAlign.center,
                                      style:
                                          Theme.of(context).textTheme.titleSmall,
                                    ),
                                  ),
                                  Image.asset(
                                    'assets/images/balloon_purple.png',
                                    height: balloonHeight,
                                  ),
                                ],
                              ),
                              // Evil Balloon Instructions
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Image.asset(
                                    'assets/images/balloon_evil.png',
                                    height: balloonHeight,
                                  ),
                                  SizedBox(
                                    width: game.size.x / 2,
                                    child: Text(
                                      '-10 points\nLose a life!',
                                      softWrap: true,
                                      textAlign: TextAlign.center,
                                      style:
                                          Theme.of(context).textTheme.titleSmall,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // Back Button (removes this overlay)
                ElevatedButton(
                  onPressed: () async {
                    //game.pause();
                    game.overlays.remove('instructionsOverlay');
                  },
                  child: const Text('Back'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
