import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../share_preferences/preferences.dart';

class PageView1 extends StatefulWidget {
  final PageController controller;

  const PageView1(this.controller, {Key? key}) : super(key: key);

  @override
  State<PageView1> createState() => _PageView1State();
}

class _PageView1State extends State<PageView1> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          width: size.width * 0.9,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  child: MaterialButton(
                    onPressed: () {
                      Preferences.isTutorialActived = true;
                      Navigator.pushReplacementNamed(context, '/googleMaps');
                    },
                    child: SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.arrow_back_ios,
                            size: 15.0,
                            color: Colors.black54,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            'Omitir',
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 15.0,
                            color: Colors.black54,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                FadeInRight(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.transparent,
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.2),
                            blurRadius: 10.0,
                            spreadRadius: 1.0,
                            offset: Offset(0.0, 8.0)),
                      ],
                    ),
                    child: Image(
                      width: size.width * 0.15,
                      height: size.width * 0.15,
                      image: const AssetImage("images/filtro.png"),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                FadeInRight(
                  delay: const Duration(milliseconds: 250),
                  child: SizedBox(
                    width: size.width * 0.8,
                    child: const Text(
                      'Seleccionando el icono filtrar se te desplegara una lista del tipo de actividades',
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18.0,
                          height: 1.3),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                FadeInRight(
                  delay: const Duration(milliseconds: 500),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 80.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.transparent,
                            boxShadow: const [
                              BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.2),
                                  blurRadius: 10.0,
                                  spreadRadius: 2.0,
                                  offset: Offset(0.0, 5.0)),
                            ],
                          ),
                          child: Image(
                            width: size.width * 0.15,
                            height: size.width * 0.15,
                            image: const AssetImage(
                                "images/actibarrio_deporte.png"),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.transparent,
                          boxShadow: const [
                            BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.2),
                                blurRadius: 10.0,
                                spreadRadius: 2.0,
                                offset: Offset(0.0, 5.0)),
                          ],
                        ),
                        child: Image(
                          width: size.width * 0.15,
                          height: size.width * 0.15,
                          image: const AssetImage(
                              "images/actibarrio_sociales.png"),
                        ),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.transparent,
                          boxShadow: const [
                            BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.2),
                                blurRadius: 10.0,
                                spreadRadius: 2.0,
                                offset: Offset(0.0, 5.0)),
                          ],
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.transparent,
                            boxShadow: const [
                              BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.2),
                                  blurRadius: 5.0,
                                  offset: Offset(0.0, 3.0)),
                            ],
                          ),
                          child: Image(
                            width: size.width * 0.15,
                            height: size.width * 0.15,
                            image:
                                const AssetImage("images/actibarrio_arte.png"),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 80.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.transparent,
                            boxShadow: const [
                              BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.2),
                                  blurRadius: 10.0,
                                  spreadRadius: 2.0,
                                  offset: Offset(0.0, 5.0)),
                            ],
                          ),
                          child: Image(
                            width: size.width * 0.15,
                            height: size.width * 0.15,
                            image: const AssetImage(
                                "images/actibarrio_cursos.png"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                FadeInRight(
                  delay: const Duration(milliseconds: 750),
                  child: SizedBox(
                    width: size.width * 0.8,
                    height: size.height * 0.15,
                    child: const Text(
                      'Con los iconos de los distintos tipos de actividades vas a poder filtrarlas',
                      overflow: TextOverflow.clip,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18.0,
                          height: 1.3),
                    ),
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
