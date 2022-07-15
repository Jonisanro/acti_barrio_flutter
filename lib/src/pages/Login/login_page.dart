import 'package:acti_barrio_flutter/src/loginService/auth_service.dart';
import 'package:acti_barrio_flutter/src/provider/loading_provider.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import '../../helpers/global_functions.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
    final loadingProvicer = Provider.of<LoadingProvider>(context);
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Colors.white.withOpacity(0.8)),
                  ),
                  onPressed: () async {
                    bool result =
                        await InternetConnectionChecker().hasConnection;
                    if (result) {
                      loadingProvicer.loadingOn = true;

                      AuthService().signInWithGoogle(context);
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          title: const Text("Error"),
                          content: const Text(
                              "No hay conexión a internet, intente nuevamente"),
                          actions: [
                            TextButton(
                              child: const Text("Aceptar"),
                              onPressed: () => Navigator.of(context).pop(),
                            )
                          ],
                        ),
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Image(
                          image: AssetImage("images/google.png"),
                          height: 35.0,
                          width: 35.0,
                        ),
                        SizedBox(width: 20.0),
                        Text(
                          'Ingresar con Google',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  )),
              SizedBox(height: size.height * 0.05),
              (() {
                return FutureBuilder(
                  future: getPrimeraCarga(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.data == true) {
                      return ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Colors.white.withOpacity(0.8)),
                          ),
                          onPressed: () async {
                            Navigator.pushReplacementNamed(
                                context, '/googleMaps');
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Image(
                                  image: AssetImage("images/no_wifi.png"),
                                  height: 35.0,
                                  width: 35.0,
                                ),
                                SizedBox(width: 20.0),
                                Text(
                                  'Continuar sin Conexion',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          ));
                    } else {
                      return Container();
                    }
                  },
                );
              })(),
              if (loadingProvicer.loadingOn)
                const Center(child: CircularProgressIndicator())
              else
                Container(),
            ],
          ),
        ),
      ],
    );
  }
}
