import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../share_preferences/preferences.dart';

class PageView4 extends StatefulWidget {
  const PageView4({
    Key? key,
  }) : super(key: key);

  @override
  State<PageView4> createState() => _PageView4State();
}

class _PageView4State extends State<PageView4> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          width: size.width * 0.9,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FadeInRight(
                  child: Container(
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.2),
                            blurRadius: 10.0,
                            spreadRadius: 2.0,
                            offset: Offset(0.0, 5.0)),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image(
                        width: size.width * 0.7,
                        height: size.width * 0.7,
                        fit: BoxFit.cover,
                        image: const AssetImage("images/detalles.png"),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                FadeInRight(
                  delay: const Duration(milliseconds: 250),
                  child: SizedBox(
                    width: size.width * 0.9,
                    child: const Text(
                      'En la pagina de detalles podras acceder a toda la informacion del evento',
                      overflow: TextOverflow.clip,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
                FadeInRight(
                  delay: const Duration(milliseconds: 500),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 15.0,
                      ),
                      ElevatedButton(
                          onPressed: () async => Navigator.popAndPushNamed(
                              context, '/google_maps'),
                          child: const Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Text('Ir al mapa'),
                          )),
                      const SizedBox(height: 15.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'No volver a mostrar',
                            style: TextStyle(fontSize: 15.0),
                          ),
                          Switch(
                            value: Preferences.isTutorialActived,
                            onChanged: (value) {
                              setState(() {
                                Preferences.isTutorialActived = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
