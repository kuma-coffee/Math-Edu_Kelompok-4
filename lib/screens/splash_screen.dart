import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:maths_edu/screens/components/body.dart';
import 'package:maths_edu/screens/homePage/home_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              'assets/images/launch_image.png',
              height: 250.0,
              width: 250.0,
            ),
          ]),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      //const Color(0xFFFF800B),
      nextScreen: Body(),
      splashIconSize: 300,
      duration: 2000,
      splashTransition: SplashTransition.fadeTransition,
    );
  }
}
