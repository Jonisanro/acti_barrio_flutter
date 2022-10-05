import 'package:flutter/material.dart';

class ShowDialogNoConnection {
  alerta(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        title: const Text("Error"),
        content: const Text("No hay conexión a internet, intente nuevamente"),
        actions: [
          TextButton(
            child: const Text("Aceptar"),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      ),
    );
  }
}
