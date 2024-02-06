import 'dart:async';
import 'dart:ui';

import 'package:daniel_mcerlean_project_3/game/components/background.dart';
import 'package:daniel_mcerlean_project_3/game/gamemodes/balloon_defense.dart';

import 'components/balloons.dart';
import 'gamemodes/rising_balloons.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';

import 'managers/game_manager.dart';
import 'managers/settings_manager.dart';
import 'components/cloud.dart';

// utilizes help from this tutorial:
// https://github.com/flutter/codelabs/blob/main/flame-building-doodle-dash/finished_game/lib/game/doodle_dash.dart

///
/// BalloonPop is the main FlameGame class that handles loading assets/music, spawning objects, deleting objects, and more
///
class BalloonPop extends FlameGame with HasCollisionDetection {
  // Managers to make certain states and variables easier to 'manage'.
  // Based on the managers in the doodledash tutorial
  GameManager gameManager = GameManager();
  SettingsManager settingsManager = SettingsManager();

  // Game Modes
  RisingBalloons risingBalloons = RisingBalloons();
  BalloonDefense balloonDefense = BalloonDefense();

  late BackgroundComponent backgroundComponent;

  // balloon spawn time variables
  double spawnBalloonTime = 1.5;
  double currBalloonTime = 0;

  // lowering balloon spawn time variables
  double lowerSpawnTime = 3;
  double minSpawnTime = .25;
  double lowerSpawnTimeBy = .05;
  double currTime = 0;

  // cloud spawn time variables
  double spawnCloudTime = 4;
  double currCloudTime = 3;

  //
  //  OnLoad loads all assets, music, settingsManager,
  //  and starts the background music
  //
  @override
  FutureOr<void> onLoad() async {
    // load assets
    await images.loadAll(
      [
        "cloud.png",
        "balloon_green.png",
        "balloon_yellow.png",
        "balloon_red.png",
        "balloon_purple.png",
        "balloon_evil.png",
      ],
    );
    // load audio
    await FlameAudio.audioCache.loadAll(
      [
        'background.wav',
        'pop1.wav',
        'pop2.wav',
        'pop3.wav',
        'bounce2.wav',
        'explosion.wav',
      ],
    );

    backgroundComponent = BackgroundComponent()..size = size;
    add(backgroundComponent);

    add(risingBalloons);
    add(balloonDefense);

    // called so that shared_preferences is initialized before trying to access it
    await settingsManager.onLoad();

    startBgmMusic();
  }

  //
  //  startBgmMusic()
  //  handles FlameAudio.bgm intialization, plays the background music,
  //  and sets the volume to the shared_preferences musicVolume
  //
  void startBgmMusic() async {
    FlameAudio.bgm.initialize();
    FlameAudio.bgm.play('background.wav', volume: settingsManager.musicVolume);
  }

  //
  //  pauseBgmMusic()
  //  utility function for pausing the music from different overlays
  //
  void pauseBgmMusic() {
    FlameAudio.bgm.pause();
  }

  //
  //  resumeBgmMusic()
  //  utility function for resuming the music from different overlays
  //
  void resumeBgmMusic() {
    FlameAudio.bgm.resume();
  }

  //
  //  backgroundColor()
  //  changes the background color of the app to the 'sky blue'-like color
  //
  // @override
  // Color backgroundColor() {
  //   return const Color.fromARGB(255, 104, 174, 255);
  // }

  //
  //  update()
  //  handles spawning clouds, and different actions depending on gameState
  //
  @override
  void update(double dt) {
    super.update(dt);

    // spawn clouds every spawnCloudTime seconds if:
    //    player is on main menu
    //    gamemode is risingBalloons + game modes with clouds
    if (gameManager.isIntro || gameManager.isRisingBalloons) {
      currCloudTime += dt;
      if (currCloudTime >= spawnCloudTime) {
        currCloudTime = 0;

        // spawn cloud
        Cloud cloud = Cloud();
        add(cloud);
      }
    }

    // If game has not started
    if (gameManager.isIntro) {
      overlays.add('mainMenuOverlay');
    }

    // // if game has started
    // if (gameManager.isPlaying) {
    //   // spawn balloons based on elapsed deltaTime
    //   currBalloonTime += dt;
    //   if (currBalloonTime >= spawnBalloonTime) {
    //     currBalloonTime = 0;

    //     spawnBalloons();
    //   }

    //   // lower spawnBalloonTime every lowerSpawnTime seconds
    //   // AND only lower if spawnBalloonTime is greater than minSpawnTime
    //   currTime += dt;
    //   if (currTime >= lowerSpawnTime && spawnBalloonTime > minSpawnTime) {
    //     currTime = 0;
    //     spawnBalloonTime -= lowerSpawnTimeBy;
    //   }

    //   // if player runs out of lives
    //   if (gameManager.life.value <= 0) {
    //     onLose();
    //   }
    // }
  }

  // //
  // //  SpawnBalloons()
  // //  Picks a random int from 0 to 99, spawns a balloon based on that number
  // //
  // void spawnBalloons() {
  //   int random = Random().nextInt(100);

  //   // 2 percent chance
  //   if (random < 2) {
  //     BalloonPurple balloon = BalloonPurple();
  //     add(balloon);
  //   }
  //   // 10 percent chance
  //   else if (random >= 2 && random < 12) {
  //     BalloonEvil balloon = BalloonEvil();
  //     add(balloon);
  //   }
  //   // 15 percent chance
  //   else if (random >= 12 && random < 27) {
  //     BalloonRed balloon = BalloonRed();
  //     add(balloon);
  //   }
  //   // 30 percent chance
  //   else if (random >= 27 && random < 57) {
  //     BalloonYellow balloon = BalloonYellow();
  //     add(balloon);
  //   }
  //   // 43 percent chance
  //   else {
  //     BalloonGreen balloon = BalloonGreen();
  //     add(balloon);
  //   }
  // }

  //
  //  removeAllBalloons()
  //  utility function for removing all instances of Balloons
  //
  void removeAllBalloons() {
    removeAll(children.query<Balloons>());
  }

  //
  //  changeMusicVolume()
  //  utility function for changing the music volume in settings
  //
  void changeMusicVolume(double value) {
    // restarts song because I can't store bgm music in a variable to reuse
    FlameAudio.bgm.play('background.wav', volume: value);
    settingsManager.setMusicVolume(value);
  }

  //
  // changeVFXVolume()
  //  utility function for changing the vfx volume in settings
  //
  void changeVFXVolume(double value) {
    // won't effect ballloons currently on screen
    FlameAudio.play('pop1.wav', volume: value);
    settingsManager.setVFXVolume(value);
  }

  void changeVibration(bool value) {
    settingsManager.setVibration(value);
  }

  //
  //  initializeGameStart()
  //  called when starting the game,
  //  resets gameState to isPlaying, resets spawn times,
  //  sets paused to false, and adds the gameOverlay (UI)
  //
  // void initializeGameStart() {
  //   gameManager.reset();
  //   spawnBalloonTime = 1.5;
  //   currBalloonTime = 0;
  //   currTime = 0;
  //   paused = false;
  //   overlays.add('gameOverlay');
  // }

  //
  //  startGame()
  //  used to easily start the game from the mainMenuOverlay
  //
  void startGame() {
    // initializeGameStart();
    // gameManager.state = GameState.playing;
    // overlays.remove('mainMenuOverlay');
    // resumeEngine();

    switch (gameManager.mode) {
      case GameMode.risingBalloons:
        risingBalloons.startGame();
        break;

      case GameMode.balloonDefense:
        balloonDefense.startGame();
        break;
    }
  }

  //
  //  resetGame()
  //  used to restart the game from gameOverOverlay or pauseOverlay
  //
  void resetGame() {
    //startGame();
    //removeAllBalloons();
    //overlays.remove('gameOverOverlay');
    //overlays.remove('pauseOverlay');

    switch (gameManager.mode) {
      case GameMode.risingBalloons:
        risingBalloons.resetGame();
        break;

      case GameMode.balloonDefense:
        break;
    }
  }

  //
  //  endGame()
  //  used to end the game and display the mainMenuOverlay
  //
  void endGame() {
    // gameManager.reset();
    // //removeAllBalloons();
    // overlays.remove('gameOverOverlay');
    // overlays.remove('gameOverlay');
    // overlays.remove('pauseOverlay');
    // overlays.add('mainMenuOverlay');
    // resumeEngine();

    switch (gameManager.mode) {
      case GameMode.risingBalloons:
        risingBalloons.endGame();
        break;

      case GameMode.balloonDefense:
      balloonDefense.endGame();
        break;
    }
  }

  // //
  // //  onLose()
  // //  called when the player runs out of lives,
  // //  sets state to gameOver and displays the gameOverOverlay
  // //
  // void onLose() {
  //   gameManager.state = GameState.gameOver;
  //   overlays.remove('gameOverlay');
  //   overlays.add('gameOverOverlay');
  // }

  //
  //  pause()
  //  called when the player presses the pause button, pauses the game engine.
  //  unpauses the game engine when the player presses resume.
  //
  void pause() {
    if (!paused) {
      overlays.remove('gameOverlay');
      overlays.add('pauseOverlay');
      pauseEngine();
    } else {
      overlays.remove('pauseOverlay');
      overlays.add('gameOverlay');
      resumeEngine();
    }
  }
}
