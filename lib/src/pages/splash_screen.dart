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

//TODO: Agregar animaciones
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: const Image(
        image: AssetImage('images/app_actibarrio.png'),
        height: double.infinity,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
      nextScreen: const HomePage(),
      duration: 2000,
      centered: true,
      splashIconSize: double.infinity,
      animationDuration: const Duration(milliseconds: 500),
      splashTransition: SplashTransition.slideTransition,
      curve: Curves.easeInOut,
    );
  }
}
