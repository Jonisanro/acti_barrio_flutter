import 'package:acti_barrio_flutter/src/pages/home_page.dart';
import 'package:acti_barrio_flutter/src/pages/splash_screen.dart';

import 'package:flutter/material.dart';


void main() => runApp(MyApp());

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  
  Widget build(BuildContext context) {
    
    return  MaterialApp(
      routes:{
        '/home': (BuildContext context) => HomePage(),
        '/splash': (BuildContext context) => const SplashScreen(),
      },
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: const SplashScreen(),
    );
  }
}