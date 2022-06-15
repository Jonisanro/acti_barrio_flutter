import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class PageView2 extends StatefulWidget {
  const PageView2({
    Key? key,
  }) : super(key: key);

  @override
  State<PageView2> createState() => _PageView2State();
}

class _PageView2State extends State<PageView2> {
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FadeInRight(
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
                    child: const Image(
                      width: 80,
                      height: 80,
                      image: AssetImage("images/actibarrio_barrios.png"),
                    ),
                  ),
                ),
                FadeInRight(
                  delay: const Duration(milliseconds: 250),
                  child: SizedBox(
                    width: size.width * 0.8,
                    child: const Text(
                      'Con el icono barrios vas a poder visibilizar los barrios de la ciudad',
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 19.0,
                          height: 1.3),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50.0,
                ),
                FadeInRight(
                  delay: const Duration(milliseconds: 500),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.2),
                            blurRadius: 10.0,
                            spreadRadius: 2.0,
                            offset: Offset(0.0, 5.0)),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: const Image(
                        fit: BoxFit.cover,
                        image: AssetImage("images/evento.png"),
                      ),
                    ),
                  ),
                ),
                FadeInRight(
                  delay: const Duration(milliseconds: 750),
                  child: SizedBox(
                    width: size.width * 0.8,
                    child: const Text(
                      'Haciendo click sobre los eventos podras ver informacion sobre ellos, y seleccionando el recuadro accederas a mas detelles',
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 19.0,
                          height: 1.3),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
