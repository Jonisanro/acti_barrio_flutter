import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';

import '../loginService/auth_service.dart';
import '../provider/markers_provider.dart';
import '../widgets/show_dialog_no_connection.dart';

class NoDataPage extends StatelessWidget {
  const NoDataPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final markersProviders =
        Provider.of<MarkersProviders>(context, listen: false);

    return Scaffold(
      body: _ContentBody(markersProviders: markersProviders, size: size),
    );
  }
}

class _ContentBody extends StatelessWidget {
  const _ContentBody({
    Key? key,
    required this.markersProviders,
    required this.size,
  }) : super(key: key);

  final MarkersProviders markersProviders;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.topRight,
          stops: const [0.04, 0.5, 1],
          colors: [
            Colors.amberAccent.shade400,
            Colors.amber.shade200.withOpacity(0.4),
            Colors.amberAccent.shade400,
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () {
                    if (markersProviders.primeraCarga == true) {
                      Navigator.pop(context);
                    } else {
                      if (Platform.isAndroid) {
                        SystemNavigator.pop();
                      } else if (Platform.isIOS) {
                        exit(0);
                      }
                    }
                  },
                  icon: const Icon(Icons.close),
                  iconSize: 35.0,
                  color: Colors.black.withOpacity(0.7),
                ),
              ),
              Image(
                height: size.height * 0.20,
                image: const AssetImage('images/no_wifi.png'),
                fit: BoxFit.cover,
              ),
              SizedBox(height: size.height * 0.1),
              Text(
                'No tiene conexion a Internet',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: size.height * 0.03,
                    height: 1.3,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: size.width * 0.8,
                child: Text(
                  'Revise su conexion de wifi o datos, y vuelva a intentar',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.7),
                      fontSize: size.height * 0.025,
                      height: 1.3,
                      fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  )),
                  backgroundColor: MaterialStateProperty.all(
                    Colors.black,
                  ),
                  elevation: MaterialStateProperty.all(0.0),
                ),
                onPressed: () async {
                  bool result = await InternetConnectionChecker().hasConnection;
                  if (result) {
                    AuthService().signInWithGoogle(context);
                  } else {
                    ShowDialogNoConnection().alerta(context);
                  }
                },
                child: SizedBox(
                    width: size.width * 0.6,
                    height: size.height * 0.05,
                    child: const Center(
                        child: Text(
                      'Reintentar',
                      style: TextStyle(height: 1.3, fontSize: 15.0),
                    ))),
              ),
              (() {
                if (markersProviders.primeraCarga == true) {
                  return ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      )),
                      backgroundColor: MaterialStateProperty.all(
                        Colors.black,
                      ),
                      elevation: MaterialStateProperty.all(0.0),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: SizedBox(
                        width: size.width * 0.6,
                        height: size.height * 0.05,
                        child: const Center(
                            child: Text(
                          'Continuar sin conexion',
                          style: TextStyle(height: 1.3, fontSize: 15.0),
                        ))),
                  );
                } else {
                  return Container();
                }
              })()
            ]),
      ),
    );
  }
}
