import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../balloon_pop.dart';

///
/// GameManager handles the score, player lives, and gameState
///
class GameManager extends Component with HasGameRef<BalloonPop> {
  GameManager();

  // value notifiers for score and life to display on screen in real-time
  ValueNotifier<int> score = ValueNotifier(0);
  ValueNotifier<int> life = ValueNotifier(5);

  // initializes GameState to intro
  GameState state = GameState.intro;

  GameMode mode = GameMode.risingBalloons;

  // getters for GameState
  bool get isPlaying => state == GameState.playing;
  bool get isGameOver => state == GameState.gameOver;
  bool get isIntro => state == GameState.intro;

  bool get isRisingBalloons => mode == GameMode.risingBalloons;
  bool get isBalloonDefense => mode == GameMode.balloonDefense;

  //
  //  reset()
  //  resets the score and life to their base values
  //
  void reset() {
    score.value = 0;
    life.value = 5;
    state = GameState.intro;
  }

  //
  //  increaseScore()
  //  increases the players score
  //
  void increaseScore(int value) {
    score.value += value;
  }

  //
  //  decreaseLife()
  //  decreases the players life
  //
  void decreaseLife() {
    life.value--;
  }
}

// GameState enum
enum GameState { intro, playing, gameOver }

enum GameMode { risingBalloons, balloonDefense }
