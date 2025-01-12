import 'package:flutter/material.dart';

class SugerenciaPage extends StatelessWidget {
  const SugerenciaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
          size: 30.0,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      body: ListView(children: [
        _image(context),
        const SizedBox(height: 20),
        _textDescription(context),
      ]),
    );
  }

  Widget _image(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Image(
      fit: BoxFit.cover,
      width: double.infinity,
      height: size.height * 0.4,
      image: const AssetImage('images/app_actibarrio.png'),
    );
  }

  Widget _textDescription(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Tu opinion nos importa',
          style: TextStyle(
              color: Color.fromARGB(187, 16, 16, 16),
              fontSize: 20.0,
              height: 1.3,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: size.height * 0.05,
        ),
        SizedBox(
          width: size.width * 0.9,
          child: const Text(
            'Si nos quieres realizar un comentario o sugerencias de nuestra APP , acerca del contenido,  lo podes realizar al siguiente',
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Color.fromARGB(187, 16, 16, 16),
                fontSize: 18.0,
                height: 1.3,
                fontWeight: FontWeight.normal),
          ),
        ),
        const SizedBox(
          height: 40.0,
        ),
        Container(
          width: size.width * 0.7,
          height: size.height * 0.06,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: const [0.1, 0.5, 1],
              colors: [
                Colors.amberAccent.shade400,
                Colors.amber.shade200,
                Colors.amberAccent.shade400,
              ],
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
              elevation: MaterialStateProperty.all(0.0),
              enableFeedback: false,
            ),
            child: const Text(
              'Enviar sugerencia',
              style: TextStyle(
                  color: Color.fromARGB(187, 16, 16, 16),
                  fontSize: 20.0,
                  height: 1.3,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
