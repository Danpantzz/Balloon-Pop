import 'dart:io';

import 'package:daniel_mcerlean_project_3/overlays/game_modes_overlay.dart';
import 'package:daniel_mcerlean_project_3/src/games_services/games_services.dart';
import 'package:flutter/foundation.dart';
//import 'package:games_services/games_services.dart' as gs;
import 'package:provider/provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';

import 'game/balloon_pop.dart';
import 'light_theme.dart';
//import 'dark_theme.dart';
import 'overlays/exit_overlay.dart';
import 'overlays/game_over_overlay.dart';
import 'overlays/game_overlay.dart';
import 'overlays/settings_overlay.dart';
import 'overlays/instructions_overlay.dart';
import 'overlays/main_menu_overlay.dart';
import 'overlays/pause_overlay.dart';
import 'overlays/credits_overlay.dart';

///
/// Main function that starts it all
///
void main() {
  // keep splash screen on display until everything is initialized in MainApp
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  GamesServicesController? gamesServicesController;
  if (!kIsWeb && (Platform.isIOS || Platform.isAndroid)) {
    gamesServicesController = GamesServicesController()
      // Attempt to log the player in.
      ..initialize();
  }

  runApp(MainApp(
    gamesServicesController: gamesServicesController,
  ));

  // Remove splash after initialization
  FlutterNativeSplash.remove();
}

class MainApp extends StatelessWidget {
  final GamesServicesController? gamesServicesController;

  const MainApp({required this.gamesServicesController, super.key});

  //
  //  Stateless build method that removes the debug banner, sets up theme and home page
  //
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<GamesServicesController?>.value(
            value: gamesServicesController),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme(context),
        //darkTheme: darkTheme(context),
        home: const HomePage(),
      ),
    );
  }
}

// getting reference to Flame game
final Game game = BalloonPop();

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  // App life cycle for preventing things from continuing while app is "paused" or minimized
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    //print('State: $state');

    switch (state) {
      case AppLifecycleState.resumed:
        if (!game.overlays.isActive('pauseOverlay')) game.resumeEngine();
        break;
      case AppLifecycleState.hidden:
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
        game.pauseEngine();
        break;
      case AppLifecycleState.detached:
        game.pauseEngine();
        break;
    }
  }

  // add this as an observer to WidgetsBinding so that AppLifecycleState can be monitored
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  // building app page
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              constraints: const BoxConstraints(
                maxWidth: 800,
                minWidth: 550,
              ),
              // game lives inside this scaffold, rather than the whole app being just the GameWidget
              child: GameWidget(
                game: game,
                overlayBuilderMap: <String,
                    Widget Function(BuildContext, Game)>{
                  // Main Menu
                  'mainMenuOverlay': (context, game) => MainMenuOverlay(game),

                  // Game Modes
                  'gameModesOverlay': (context, game) => GameModesOverlay(game),

                  // UI menu
                  'gameOverlay': (context, game) => GameOverlay(game),

                  // Settings
                  'settingsOverlay': (context, game) => SettingsOverlay(game),

                  // Credits
                  'creditsOverlay': (context, game) => CreditsOverlay(game),

                  // Instructions
                  'instructionsOverlay': (context, game) =>
                      InstructionsOverlay(game),

                  // Game Over Screen
                  'gameOverOverlay': (context, game) => GameOverOverlay(game),

                  // Pause Screen
                  'pauseOverlay': (context, game) => PauseOverlay(game),

                  // Exit Screen (when pressing back button on Main Menu)
                  'exitOverlay': (context, game) => ExitOverlay(game),
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
