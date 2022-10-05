import 'package:acti_barrio_flutter/src/loginService/auth_service.dart';

import 'package:acti_barrio_flutter/src/widgets/show_dialog_no_connection.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../helpers/global_functions.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

bool loadingProvicer = false;

class _LoginPageState extends State<LoginPage> {
  @override
  void dispose() {
    loadingProvicer = false;
    super.dispose();
  }

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
        SizedBox(height: size.height * 0.2),
        SizedBox(
          width: size.width * 0.9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all(
                        Colors.white.withOpacity(0.8)),
                  ),
                  onPressed: () async {
                    bool result =
                        await InternetConnectionChecker().hasConnection;
                    if (result) {
                      setState(() {
                        loadingProvicer = true;
                      });

                      AuthService().signInWithGoogle(context);
                    } else {
                      ShowDialogNoConnection().alerta(context);
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
                          height: 25.0,
                          width: 25.0,
                        ),
                        SizedBox(width: 20.0),
                        Text(
                          'Ingresar con Google',
                          style: TextStyle(color: Colors.black, fontSize: 15.0),
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
                            setState(() {
                              loadingProvicer = false;
                            });
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
              loadingProvicer
                  ? const Center(child: CircularProgressIndicator())
                  : Container(),
            ],
          ),
        ),
      ],
    );
  }
}
