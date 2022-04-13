import 'package:acti_barrio_flutter/src/pages/home_page.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';

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
      splash: 'images/carga.gif',
      nextScreen: HomePage(),
      duration: 2500,
      splashIconSize: 200,
      animationDuration:  const Duration(milliseconds: 1000),
      splashTransition: SplashTransition.slideTransition,
      curve:  Curves.easeInOut,
     
    
    );
  }

}