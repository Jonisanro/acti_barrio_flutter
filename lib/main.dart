import 'package:acti_barrio_flutter/src/pages/acerca_nuestro_page.dart';

import 'package:acti_barrio_flutter/src/pages/event_descriptor_page.dart';
import 'package:acti_barrio_flutter/src/pages/favorites_page.dart';
import 'package:acti_barrio_flutter/src/pages/google_maps_page.dart';
import 'package:acti_barrio_flutter/src/pages/home_page.dart';
import 'package:acti_barrio_flutter/src/pages/splash_screen_page.dart';
import 'package:acti_barrio_flutter/src/pages/sugerencia_page.dart';
import 'package:acti_barrio_flutter/src/provider/filtros_provider.dart';

import 'package:acti_barrio_flutter/src/provider/mapbox_info.dart';
import 'package:acti_barrio_flutter/src/provider/markers_provider.dart';
import 'package:acti_barrio_flutter/src/share_preferences/preferences.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();

  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => FiltrosProviders(),
        ),
        ChangeNotifierProvider(lazy: false, create: (_) => BarriosInfo()),
        ChangeNotifierProvider(
          create: (_) => MarkersProviders(),
          lazy: false,
        ),
      ],
      child: MaterialApp(
        routes: {
          '/home': (BuildContext context) => const HomePage(),
          '/google_maps': (BuildContext context) => const GoogleMapsPage(),
          '/splash': (BuildContext context) => const SplashScreen(),
          '/eventDescriptor': (BuildContext context) => const EventDescriptor(),
          '/acercaDe': (BuildContext context) => const AcercaDePage(),
          '/favorite': (BuildContext context) => const FavoritesPage(),
          '/sugerencia': (BuildContext context) => const SugerenciaPage(),
        },
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        home: const SplashScreen(),
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
            color: Color.fromRGBO(81, 167, 177, 1),
            elevation: 0,
            toolbarTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
