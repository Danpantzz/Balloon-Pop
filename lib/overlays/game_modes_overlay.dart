import 'package:carousel_slider/carousel_slider.dart';
import 'package:daniel_mcerlean_project_3/game/managers/game_manager.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../game/balloon_pop.dart';
import '../src/games_services/games_services.dart';

var imgList = [
  {
    'image': 'assets/images/logo_icon.png',
    'name': 'Rising Balloons',
    'mode': GameMode.risingBalloons,
    'leaderboard': "CgkIxqXw6oIREAIQAQ"
  },
  {
    'image': 'assets/images/logo_icon.png',
    'name': 'Balloon Defense',
    'mode': GameMode.balloonDefense,
    'leaderboard': ""
  },
];

// final List<Widget> imageSliders = imgList
//     .map(
//       (item) => Container(
//         margin: const EdgeInsets.all(5.0),
//         child: Column(
//           children: [
//             ClipRRect(
//               borderRadius: const BorderRadius.all(Radius.circular(5.0)),
//               child: Image.asset(
//                 item.elementAt(0),
//                 fit: BoxFit.cover,
//                 width: 200,
//               ),
//             ),
//             const Gap(50),
//             Text(item.elementAt(1), style: Theme.of(context).textTheme.titleLarge,),
//           ],
//         ),
//       ),
//     )
//     .toList();

class GameModesOverlay extends StatefulWidget {
  const GameModesOverlay(this.game, {super.key});

  final Game game;

  @override
  State<GameModesOverlay> createState() => _GameModesOverlayState();
}

class _GameModesOverlayState extends State<GameModesOverlay> {
  int _current = 0;
  final CarouselController carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    BalloonPop game = widget.game as BalloonPop;
    final gamesServicesController = context.watch<GamesServicesController?>();

    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          alignment: Alignment.bottomCenter,
          width: game.size.x / 1.1,
          height: game.size.y / 1.1,
          margin: const EdgeInsets.only(top: 20),
          padding: const EdgeInsets.all(8.0),
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

          // Screen column
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  alignment: Alignment.topRight,
                  padding: const EdgeInsets.only(bottom: 10),
                  icon: const Icon(Icons.cancel),
                  iconSize: 30,
                  onPressed: () {
                    game.overlays.remove('gameModesOverlay');
                  },
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Page Title
                  Column(
                    children: [
                      Text(
                        'Game Modes',
                        style: Theme.of(context).textTheme.titleMedium,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),

                  // Carousel
                  carousel(context, game, gamesServicesController),

                  imgList[_current]['name'] == 'Balloon Defense'
                      ? const ElevatedButton(
                          onPressed: null,
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.grey),
                            foregroundColor:
                                MaterialStatePropertyAll(Colors.white),
                          ),
                          child: Text('Coming Soon'),
                        )
                      : ElevatedButton(
                          onPressed: () async {
                            game.gameManager.mode =
                                imgList[_current]['mode'] as GameMode;

                            game.overlays.remove('gameModesOverlay');
                            game.startGame();
                          },
                          child: const Text('Play'),
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  CarouselSlider carousel(BuildContext context, BalloonPop game,
      GamesServicesController? gamesServicesController) {
    return CarouselSlider(
      items: imgList
          .map(
            (item) => Container(
              //margin: const EdgeInsets.all(5.0),
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 184, 232, 255),
                border: Border.all(
                  color: Colors.black,
                  width: 2,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              ),
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Gap(8),
                      Text(
                        item['name'].toString(),
                        style: Theme.of(context).textTheme.displayLarge,
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8.0)),
                        ),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5.0)),
                          child: Image.asset(
                            item['image'].toString(),
                            fit: BoxFit.cover,
                            width: game.size.x / 1.7,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // InstructionsButton
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton.filled(
                      alignment: Alignment.topRight,
                      icon: const Icon(Icons.info),
                      iconSize: 30,
                      color: Colors.black,
                      highlightColor: Colors.grey,
                      onPressed: () {
                        game.overlays.add('instructionsOverlay');
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton.filled(
                      alignment: Alignment.topLeft,
                      icon: const Icon(Icons.leaderboard),
                      iconSize: 30,
                      color: Colors.black,
                      highlightColor: Colors.grey,
                      onPressed: () {
                        //game.overlays.add('instructionsOverlay');
                        if (item['leaderboard'].toString().length > 1) {
                          gamesServicesController!
                              .showLeaderboard(item['leaderboard']);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
      options: CarouselOptions(
        aspectRatio: .87,
        //height: game.size.y / 1.8,
        enlargeCenterPage: true,
        onPageChanged: (index, reason) {
          setState(() {
            _current = index;
          });
        },
      ),
      carouselController: carouselController,
    );
  }
}
