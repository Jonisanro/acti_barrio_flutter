import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        _background(),
        Align(alignment: Alignment.center, child: _loginGoogle(context))
      ]),
    );
  }

  _background() {
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
    );
  }

  Widget _loginGoogle(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image(
            image: const AssetImage("images/logo.png"),
            width: size.width * 0.5,
            height: size.height * 0.5),
        SizedBox(height: size.height * 0.05),
        SizedBox(
          width: size.width * 0.9,
          height: size.height * 0.08,
          child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Colors.white.withOpacity(0.8)),
              ),
              onPressed: () {
                //TODO:armar logica de login Google
                Navigator.pushNamed(context, "/google_maps");
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Image(
                    image: AssetImage("images/google.png"),
                    height: 25.0,
                    width: 25.0,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Ingresar con Google',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              )),
        ),
      ],
    );
  }
}
