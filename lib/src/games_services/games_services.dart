import 'dart:async';

import 'package:flutter/material.dart';
import 'package:games_services/games_services.dart' as gs;

import '../style/error_snackbar.dart';

/// Allows awarding achievements and leaderboard scores,
/// and also showing the platforms' UI overlays for achievements
/// and leaderboards.
///
/// A facade of `package:games_services`.
class GamesServicesController {

  final Completer<bool> _signedInCompleter = Completer();

  Future<bool> get signedIn => _signedInCompleter.future;

  /// Signs into the underlying games service.
  Future<void> initialize() async {
    try {
      await gs.GamesServices.signIn();
      // The API is unclear so we're checking to be sure. The above call
      // returns a String, not a boolean, and there's no documentation
      // as to whether every non-error result means we're safely signed in.
      final signedIn = await gs.GamesServices.isSignedIn;
      _signedInCompleter.complete(signedIn);

      // if (!signedIn) {
      //   gs.GameAuth.signIn();
      // }
    } catch (e) {
      print('Cannot log into GamesServices: $e');
      _signedInCompleter.complete(false);
    }
  }

  /// Launches the platform's UI overlay with leaderboard(s).
  Future<void> showLeaderboard() async {
    if (!await signedIn) {
      showErrorSnackbar(
        'sign in to view leaderboard',
        action: SnackBarAction(
          label: 'Sign in',
          onPressed: initialize,
        ),
      );
      print('Trying to show leaderboard when not logged in.');
      return;
    }

    try {
      await gs.GamesServices.showLeaderboards(
        androidLeaderboardID: "CgkIxqXw6oIREAIQAQ",
      );
    } catch (e) {
      print('Cannot show leaderboard: $e');
    }
  }

  /// Submits [score] to the leaderboard.
  Future<void> submitLeaderboardScore(score) async {
    if (!await signedIn) {
      print('Trying to submit leaderboard when not logged in.');
      return;
    }

    print('Submitting $score to leaderboard.');

    try {
      await gs.GamesServices.submitScore(
        score: gs.Score(
          androidLeaderboardID: 'CgkIxqXw6oIREAIQAQ',
          value: score,
        ),
      );
    } catch (e) {
      print('Cannot submit leaderboard score: $e');
    }
  }
}