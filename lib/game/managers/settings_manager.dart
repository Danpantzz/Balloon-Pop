import 'dart:async';

import 'package:flame/components.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../balloon_pop.dart';

///
/// SettingsManager for managing the volume settings
///
class SettingsManager extends Component with HasGameRef<BalloonPop> {
  SettingsManager();

  late SharedPreferences prefs;

  // getters for musicVolume and vfxVolume.
  // gets the values based on the shared_preferences value
  double get musicVolume => prefs.getDouble('musicVolume') == null
      ? 1.0
      : prefs.getDouble('musicVolume')!;
  double get vfxVolume => prefs.getDouble('vfxVolume') == null
      ? 1.0
      : prefs.getDouble('vfxVolume')!;

  //
  //  onLoad()
  //  initializes the prefs, music, and vfx variables
  //
  @override
  FutureOr<void> onLoad() async {
    // initialize prefs
    prefs = await SharedPreferences.getInstance();

    // get volume from shared_preferences
    double music = musicVolume;
    double vfx = vfxVolume;

    // set the volume to the prefs
    setMusicVolume(music);
    setVFXVolume(vfx);
  }

  //
  //  setMusicVolume()
  //  utility function for setting the musicVolume from settings, called from balloon_pop.dart
  //
  void setMusicVolume(double value) async {
    await prefs.setDouble('musicVolume', value);
  }

  //
  //  setVFXVolume()
  //  utility function for setting the vfxVolume from settings, called from balloon_pop.dart
  //
  void setVFXVolume(double value) async {
    await prefs.setDouble('vfxVolume', value);
  }

  //
  //  reset()
  //  utility function for reseting the volume to max (not called anywhere yet)
  //
  void reset() {
    setMusicVolume(1.0);
    setVFXVolume(1.0);
  }
}
