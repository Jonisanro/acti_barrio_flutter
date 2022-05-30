import 'package:acti_barrio_flutter/src/pages/PageView/page_view_1.dart';
import 'package:acti_barrio_flutter/src/pages/PageView/pagev_view_2.dart';
import 'package:acti_barrio_flutter/src/pages/PageView/page_view_3.dart';
import 'package:acti_barrio_flutter/src/widgets/slideshow.dart';
import 'package:flutter/material.dart';

import 'PageView/page_view_4.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();

    return Scaffold(
      body: Slideshow(
        colorPrimario: Colors.blueAccent,
        colorSecundario: Colors.grey,
        bulletPrimario: 15.0,
        bulletSecundario: 12.0,
        slides: [
          PageView1(controller),
          const PageView2(),
          const PageView3(),
          const PageView4(),
        ],
      ),
    );
  }
}
