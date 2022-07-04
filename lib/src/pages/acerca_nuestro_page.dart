import 'package:flutter/material.dart';

class AcercaDePage extends StatelessWidget {
  const AcercaDePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(81, 167, 177, 1),
          centerTitle: true,
          title: const Text('Ministerio MNAJC'),
        ),
        body: Stack(children: [
          ListView(children: [
            _image(context),
            const SizedBox(height: 20),
            _textDescription(context),
          ]),
          _imagenPie(context),
        ]),
      ),
    );
  }

  Widget _image(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Image(
        width: size.width * 0.8,
        height: size.height * 0.2,
        image: const AssetImage('images/ciudades_logo.png'),
      ),
    );
  }

  Widget _textDescription(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Acerca de Nosotros',
          style: TextStyle(
              color: Color.fromARGB(187, 16, 16, 16),
              fontSize: 25.0,
              height: 1.3,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: size.height * 0.02,
        ),
        Center(
          child: SizedBox(
            width: size.width * 0.9,
            child: const Text(
              'Somos  la Subsecretaria de Ciudades Saludables y Prevención de Consumos Problemáticos que acompaña e impulsa acciones, en materia de prevención de consumos, para la construcción de la ciudadanía. Y en conjunto con el departamento de Infotecnología, generamos este aplicativo. Pertenecemos al Ministerio de Niñez, Juventud, Adolescencia y Ciudadanía.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color.fromARGB(187, 16, 16, 16),
                  fontSize: 18.0,
                  height: 1.3,
                  fontWeight: FontWeight.normal),
            ),
          ),
        ),
      ],
    );
  }

  Widget _imagenPie(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Image(
          height: size.height * 0.08,
          image: const AssetImage('images/ciudades_logo2.png'),
        ),
      ),
    );
  }
}
