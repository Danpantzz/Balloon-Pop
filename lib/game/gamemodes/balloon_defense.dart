import 'dart:async';

import 'package:daniel_mcerlean_project_3/game/balloon_pop.dart';
import 'package:flame/components.dart';

import '../managers/game_manager.dart';

class BalloonDefense extends Component with HasGameRef<BalloonPop> {

  @override
  FutureOr<void> onLoad() {
    // TODO: implement onLoad
    return super.onLoad();
  }

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);

    if (!game.gameManager.isPlaying || !game.gameManager.isBalloonDefense) {
      return;
    }

    
  }

  //
  //  initializeGameStart()
  //  called when starting the game,
  //  resets gameState to isPlaying, resets spawn times,
  //  sets paused to false, and adds the gameOverlay (UI)
  //
  void initializeGameStart() {
    gameRef.gameManager.reset();
    
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
}
