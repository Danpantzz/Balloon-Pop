// Author: Daniel McErlean
// Title: Credits Page
// About: Contains documentation information, including sources and references

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../game/balloon_pop.dart';

///
/// Credits Page for viewing the documentation
/// Contains:
///   Webview for viewing documentation.html
///   Back Button
///
class CreditsOverlay extends StatefulWidget {
  const CreditsOverlay(this.game, {super.key});

  final Game game;

  @override
  State<CreditsOverlay> createState() => _CreditsOverlayState();
}

class _CreditsOverlayState extends State<CreditsOverlay> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadFlutterAsset('assets/html/documentation.html');
  }

  @override
  Widget build(BuildContext context) {
    BalloonPop game = widget.game as BalloonPop;

    // pause background music
    game.pauseBgmMusic();

    return WillPopScope(
      onWillPop: () => _goBack(context, game),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "Documentation",
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width / 12,
            ),
          ),
          centerTitle: true,
          toolbarHeight: MediaQuery.of(context).size.width < 920
              ? MediaQuery.of(context).size.width / 8
              : kToolbarHeight,

          // Back Button for leaving this page incase phone back button doesn't work
          leading: IconButton(
            onPressed: () {
              game.overlays.remove('creditsOverlay');
              game.resumeBgmMusic();
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),

        // WebviewWidget displays the HTML page
        body: WebViewWidget(controller: controller),
      ),
    );
  }

  //
  //  _goBack is called when pressing the phone's back button.
  //  will remove this overlay and resume the background music
  //
  Future<bool> _goBack(BuildContext context, BalloonPop game) async {
    game.overlays.remove('creditsOverlay');
    game.resumeBgmMusic();
    return Future.value(false);
  }
}
