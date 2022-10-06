import 'dart:convert';

import 'dart:io';
import 'package:acti_barrio_flutter/src/pages/google_maps_page.dart';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../provider/loading_provider.dart';
import '../share_preferences/preferences.dart';

class AuthService {
  signInWithGoogle(BuildContext context) async {
    final loadingProvicer =
        Provider.of<LoadingProvider>(context, listen: false);
    final prefs = await SharedPreferences.getInstance();
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No se pudo iniciar sesión'),
        ),
      );
    } else {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      /*  final url = Uri.parse("http://201.231.47.177:3002/api/auth/login"); */
      final url = Uri.parse(
          "http://10.0.2.2:3001/api/auth/login"); //TODO:CAMBIAR AL DE PRODUCCION

      final body = {
        "token": googleAuth.idToken,
        "type": "appMovil",
        "nameApp": "ActiBarrio"
      };

      //*Envia el token de google al servidor
      loadingProvicer.loadingOn = true;
      try {
        final response = await http.post(url, body: jsonEncode(body), headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer ${prefs.getString('token')}"
        }).timeout(const Duration(seconds: 30));

        final result = json.decode(response.body);

        final token = await result['token'];

        final respuesta = await result['ok'];
        final userId = await result['userId'];
        final List<String> favorites = await result['favorites'].cast<String>();

        if (respuesta) {
          prefs.setString('token', token);
          prefs.setString('userId', userId);
          prefs.remove('favorites');
          prefs.setStringList('favorites', favorites);

          !Preferences.isTutorialActived
              ? Navigator.pushReplacementNamed(context, '/home')
              : Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const GoogleMapsPage()));
          return [];
        } else {
          loadingProvicer.loadingOn = false;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('No se pudo iniciar sesión'),
            ),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No se pudo iniciar sesión',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                )),
          ),
        );
        loadingProvicer.loadingOn = false;
      }
    }
  }

  signOut() async {
    await GoogleSignIn().signOut();
  }
}