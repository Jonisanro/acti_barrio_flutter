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
        body: ListView(children: [
          _image(),
          const SizedBox(height: 20),
          _textDescription(context),
        ]),
      ),
    );
  }

  Widget _image() {
    return const Padding(
      padding: EdgeInsets.all(10.0),
      child: Image(
        width: 200,
        height: 200,
        image: AssetImage('images/filtro.png'),
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
              fontSize: 30.0,
              height: 1.3,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 20.0,
        ),
        SizedBox(
          width: size.width * 0.9,
          child: const Text(
            'Et ipsum nostrud esse nostrud. Velit id veniam non cupidatat laborum magna in consequat voluptate officia do. Culpa exercitation amet nostrud minim ad in Lorem adipisicing incididunt. Lorem elit amet laborum dolor ad irure dolore. Ullamco dolore veniam nisi cillum labore ex proident est. Sit proident occaecat minim reprehenderit magna consequat aute nostrud id occaecat mollit aliqua.',
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Color.fromARGB(187, 16, 16, 16),
                fontSize: 18.0,
                height: 1.3,
                fontWeight: FontWeight.normal),
          ),
        ),
      ],
    );
  }
}
