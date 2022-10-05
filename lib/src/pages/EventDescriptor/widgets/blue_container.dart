import 'package:flutter/material.dart';

Container blueContainer(String text) {
  return Container(
    decoration: BoxDecoration(
        color: const Color.fromRGBO(22, 117, 232, 1),
        borderRadius: BorderRadius.circular(8)),
    child: Center(
        child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
      child: Text(
        text,
        style: const TextStyle(
            color: Color.fromARGB(255, 216, 214, 214),
            fontSize: 14.0,
            fontWeight: FontWeight.bold),
      ),
    )),
  );
}
