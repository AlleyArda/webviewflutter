import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:webview/home_page.dart';
class splashscreen extends StatefulWidget {
   splashscreen({super.key});

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {

  @override
  Widget build(BuildContext context) {

    return AnimatedSplashScreen(
      splash: Icons.home,
      nextScreen: HomePage(),
      splashTransition: SplashTransition.rotationTransition,
    );
  }
}
