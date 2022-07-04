import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NoDataPage extends StatelessWidget {
  const NoDataPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    //TODO: Implementar pagina de no data
    return Scaffold(
      body: Container(
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
                      if (Platform.isAndroid) {
                        SystemNavigator.pop();
                      } else if (Platform.isIOS) {
                        exit(0);
                      }
                    },
                    icon: const Icon(Icons.close),
                    iconSize: 35.0,
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
                Image(
                  height: size.height * 0.45,
                  image: const AssetImage('images/no_wifi.png'),
                  fit: BoxFit.cover,
                ),
                const Text(
                  'No tiene conexion a Internet',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
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
                        fontSize: 15.0,
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
                  onPressed: () {
                    Navigator.pushNamed(context, "/google_maps");
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
              ]),
        ),
      ),
    );
  }
}
