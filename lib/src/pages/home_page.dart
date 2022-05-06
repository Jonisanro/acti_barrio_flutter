import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          Container(
            color: Colors.red,
          ),
          Container(
            color: Colors.green,
          ),
          Container(
            color: Colors.yellow,
            child: Center(
              child: SizedBox(
                width: 100,
                height: 100,
                child: ElevatedButton(
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, '/googl_maps'),
                  child: const Text('Siguiente'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
