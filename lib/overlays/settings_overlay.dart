import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../game/balloon_pop.dart';

///
/// Settings screen for changing volume
/// Contains:
///   Music Volume slider
///   SFX Volume slider
///   Credits Button
///   Back Button
///
class SettingsOverlay extends StatefulWidget {
  const SettingsOverlay(this.game, {super.key});

  final Game game;

  @override
  State<SettingsOverlay> createState() => _SettingsOverlayState();
}

class _SettingsOverlayState extends State<SettingsOverlay> {
  @override
  Widget build(BuildContext context) {
    BalloonPop game = widget.game as BalloonPop;

    // get previous volume settings from shared_preferences
    double musicVolume = game.settingsManager.musicVolume;
    double vfxVolume = game.settingsManager.vfxVolume;

    return Material(
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
              // Page Title
              Text(
                'Settings',
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),

              // Column used to group Slider and Slider title
              Column(
                children: [
                  // Slider title
                  Text(
                    'Music',
                    style: Theme.of(context).textTheme.titleSmall,
                    textAlign: TextAlign.center,
                  ),
                  // Music Volume slider
                  Slider(
                    divisions: 10,
                    min: 0,
                    max: 1.0,
                    value: musicVolume,
                    onChanged: (value) {
                      setState(() {
                        // set musicVolume to value
                        musicVolume = value;

                        // change shared_preferences data
                        game.settingsManager.setMusicVolume(musicVolume);
                      });
                    },
                    onChangeEnd: (value) {
                      // change music volume when finished moving slider
                      game.changeMusicVolume(musicVolume);
                    },
                  ),
                ],
              ),

              // Column used to group Slider and Slider title
              Column(
                children: [
                  // Slider title
                  Text(
                    'Sound Effects',
                    style: Theme.of(context).textTheme.titleSmall,
                    textAlign: TextAlign.center,
                  ),
                  // VFX Volume slider
                  Slider(
                    divisions: 10,
                    min: 0,
                    max: 1.0,
                    value: vfxVolume,
                    onChanged: (value) {
                      setState(() {
                        // set vfxVolume to value
                        vfxVolume = value;

                        // change shared_preferences data
                        game.settingsManager.setVFXVolume(vfxVolume);
                      });
                    },
                    onChangeEnd: (value) {
                      // change vfx volume when finished moving slider
                      game.changeVFXVolume(vfxVolume);
                    },
                  ),
                ],
              ),

              // Credits Button (documentation)
              ElevatedButton(
                onPressed: () async {
                  game.overlays.add('creditsOverlay');
                },
                child: const Text('Credits'),
              ),

              // Back Button (removes this overlay)
              ElevatedButton(
                onPressed: () async {
                  game.overlays.remove('settingsOverlay');
                },
                child: const Text('Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
