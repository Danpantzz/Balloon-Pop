import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:daniel_mcerlean_project_3/game/balloon_pop.dart';
import 'package:daniel_mcerlean_project_3/game/components/balloons.dart';
import 'package:flame/components.dart';

import '../managers/game_manager.dart';
import '../components/balloon_green.dart';
import '../components/balloon_yellow.dart';
import '../components/balloon_red.dart';
import '../components/balloon_purple.dart';
import '../components/balloon_evil.dart';

class RisingBalloons extends Component with HasGameRef<BalloonPop> {

  // balloon spawn time variables
  double spawnBalloonTime = 1.5;
  double currBalloonTime = 0;

  // lowering balloon spawn time variables
  double lowerSpawnTime = 3;
  double minSpawnTime = .25;
  double lowerSpawnTimeBy = .05;
  double currTime = 0;

  @override
  void update(double dt) {
    super.update(dt);

    // if game has started
    if (game.gameManager.isPlaying && game.gameManager.isRisingBalloons) {
      // spawn balloons based on elapsed deltaTime
      currBalloonTime += dt;
      if (currBalloonTime >= spawnBalloonTime) {
        currBalloonTime = 0;

        spawnBalloons();
      }

      // lower spawnBalloonTime every lowerSpawnTime seconds
      // AND only lower if spawnBalloonTime is greater than minSpawnTime
      currTime += dt;
      if (currTime >= lowerSpawnTime && spawnBalloonTime > minSpawnTime) {
        currTime = 0;
        spawnBalloonTime -= lowerSpawnTimeBy;
      }

      // if player runs out of lives
      if (game.gameManager.life.value <= 0) {
        onLose();
      }
    }
  }

  //
  //  SpawnBalloons()
  //  Picks a random int from 0 to 99, spawns a balloon based on that number
  //
  void spawnBalloons() {
    int random = Random().nextInt(100);

    // 2 percent chance
    if (random < 2) {
      BalloonPurple balloon = BalloonPurple();
      game.add(balloon);
    }
    // 10 percent chance
    else if (random >= 2 && random < 12) {
      BalloonEvil balloon = BalloonEvil();
      game.add(balloon);
    }
    // 15 percent chance
    else if (random >= 12 && random < 27) {
      BalloonRed balloon = BalloonRed();
      game.add(balloon);
    }
    // 30 percent chance
    else if (random >= 27 && random < 57) {
      BalloonYellow balloon = BalloonYellow();
      game.add(balloon);
    }
    // 43 percent chance
    else {
      BalloonGreen balloon = BalloonGreen();
      game.add(balloon);
    }
  }

  
  // //
  // //  removeAllBalloons()
  // //  utility function for removing all instances of Balloons
  // //
  // void removeAllBalloons() {
  //   game.removeAll(children.query<Balloons>());
  // }

    //
  //  initializeGameStart()
  //  called when starting the game,
  //  resets gameState to isPlaying, resets spawn times,
  //  sets paused to false, and adds the gameOverlay (UI)
  //
  void initializeGameStart() {
    gameRef.gameManager.reset();
    spawnBalloonTime = 1.5;
    currBalloonTime = 0;
    currTime = 0;
    game.overlays.add('gameOverlay');
  }

    //
  //  startGame()
  //  used to easily start the game from the mainMenuOverlay
  //
  void startGame() {
    initializeGameStart();
    game.gameManager.state = GameState.playing;
    game.overlays.remove('mainMenuOverlay');
    game.resumeEngine();
  }

    //
  //  resetGame()
  //  used to restart the game from gameOverOverlay or pauseOverlay
  //
  void resetGame() {
    startGame();
    game.removeAllBalloons();
    game.overlays.remove('gameOverOverlay');
    game.overlays.remove('pauseOverlay');
  }

    //
  //  endGame()
  //  used to end the game and display the mainMenuOverlay
  //
  void endGame() {
    game.gameManager.reset();
    game.removeAllBalloons();
    game.overlays.remove('gameOverOverlay');
    game.overlays.remove('gameOverlay');
    game.overlays.remove('pauseOverlay');
    game.overlays.add('mainMenuOverlay');
    game.resumeEngine();
  }

    //
  //  onLose()
  //  called when the player runs out of lives,
  //  sets state to gameOver and displays the gameOverOverlay
  //
  void onLose() {
    game.gameManager.state = GameState.gameOver;
    game.overlays.remove('gameOverlay');
    game.overlays.add('gameOverOverlay');
  }
}