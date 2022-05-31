import 'package:acti_barrio_flutter/src/pages/home_page.dart';
import 'package:acti_barrio_flutter/src/pages/google_maps_page.dart';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../share_preferences/preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: const Image(
        image: AssetImage('images/app_actibarrio.png'),
        height: double.infinity,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
      nextScreen: !Preferences.isTutorialActived
          ? const HomePage()
          : const GoogleMapsPage(),
      duration: 2000,
      centered: true,
      splashIconSize: double.infinity,
      animationDuration: const Duration(milliseconds: 300),
      splashTransition: SplashTransition.slideTransition,
      pageTransitionType: PageTransitionType.rightToLeft,
      curve: Curves.decelerate,
    );
  }
}
