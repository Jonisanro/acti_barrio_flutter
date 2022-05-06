import 'package:acti_barrio_flutter/src/pages/event_descriptor.dart';
import 'package:acti_barrio_flutter/src/pages/google_maps_page.dart';
import 'package:acti_barrio_flutter/src/pages/home_page.dart';
import 'package:acti_barrio_flutter/src/pages/splash_screen.dart';
import 'package:acti_barrio_flutter/src/provider/barrios_info.dart';
import 'package:acti_barrio_flutter/src/provider/markers_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BarriosInfo()),
        ChangeNotifierProvider(
          create: (_) => MarkersProviders(),
          lazy: false,
        ),
      ],
      child: MaterialApp(
        routes: {
          '/home': (BuildContext context) => const HomePage(),
          '/googl_maps': (BuildContext context) => const GoogleMapsPage(),
          '/splash': (BuildContext context) => const SplashScreen(),
          '/eventDescriptor': (BuildContext context) => const EventDescriptor(),
        },
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        home: const SplashScreen(),
      ),
    );
  }
}
