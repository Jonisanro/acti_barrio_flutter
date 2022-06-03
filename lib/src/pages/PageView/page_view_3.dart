import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class PageView3 extends StatefulWidget {
  const PageView3({
    Key? key,
  }) : super(key: key);

  @override
  State<PageView3> createState() => _PageView3State();
}

class _PageView3State extends State<PageView3> {
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                      child: const Image(
                        fit: BoxFit.cover,
                        image: AssetImage("images/detalles1.png"),
                      ),
                    ),
                  ),
                ),
                FadeInRight(
                  delay: const Duration(milliseconds: 500),
                  child: SizedBox(
                    width: size.width * 0.8,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Seleccionando los ',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 19.0,
                                height: 1.3),
                          ),
                          WidgetSpan(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: const Color.fromRGBO(22, 117, 232, 1),
                                  borderRadius: BorderRadius.circular(8)),
                              child: const Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Text(
                                  'Tags',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 216, 214, 214),
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          const TextSpan(
                            text:
                                ' vas a poder acceder a la informacion de eventos del mismo tipo o al barrio al que pertenece el evento ',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 19.0,
                                height: 1.3),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                FadeInRight(
                  delay: const Duration(milliseconds: 1000),
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
                      child: const Image(
                        fit: BoxFit.cover,
                        image: AssetImage("images/detalles2.png"),
                      ),
                    ),
                  ),
                ),
                FadeInRight(
                  delay: const Duration(milliseconds: 1500),
                  child: SizedBox(
                    width: size.width * 0.8,
                    child: const Text(
                      'En la pagina de detalles podras acceder a toda la informacion del evento  la informacion del evento',
                      overflow: TextOverflow.clip,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 19.0,
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
