// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class Slideshow extends StatelessWidget {
  final List<Widget> slides;
  final bool puntosArriba;
  final Color colorPrimario;
  final Color colorSecundario;
  final double bulletPrimario;
  final double bulletSecundario;

  const Slideshow({
    required this.slides,
    this.puntosArriba = false,
    this.colorPrimario = Colors.grey,
    this.colorSecundario = Colors.blue,
    this.bulletPrimario = 15,
    this.bulletSecundario = 12,
  });
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _SlideshowModel(),
      child: SafeArea(
        child: Center(child: Builder(
          builder: (BuildContext context) {
            Provider.of<_SlideshowModel>(context, listen: false).colorPrimario =
                colorPrimario;
            Provider.of<_SlideshowModel>(context, listen: false)
                .colorSecundario = colorSecundario;

            Provider.of<_SlideshowModel>(context, listen: false)
                .bulletPrimario = bulletPrimario;

            return _CrearEstructuraSideshow(
                puntosArriba: puntosArriba, slides: slides);
          },
        )),
      ),
    );
  }
}

class _CrearEstructuraSideshow extends StatelessWidget {
  const _CrearEstructuraSideshow({
    Key? key,
    required this.puntosArriba,
    required this.slides,
  }) : super(key: key);

  final bool puntosArriba;
  final List<Widget> slides;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (puntosArriba) _Dots(slides.length),
        Expanded(child: _Slides(slides)),
        if (!puntosArriba) _Dots(slides.length)
      ],
    );
  }
}

class _Dots extends StatelessWidget {
  final int totalSlides;
  const _Dots(
    this.totalSlides,
  );
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 30,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(totalSlides, (i) => _Dot(i))),
    );
  }
}

class _Dot extends StatelessWidget {
  final int index;
  const _Dot(this.index);
  @override
  Widget build(BuildContext context) {
    final ssModel = Provider.of<_SlideshowModel>(context);
    double tamano = 0;
    Color color;

    if (ssModel.currentPage >= index - 0.5 &&
        ssModel._currentPage < index + 0.5) {
      tamano = ssModel.bulletPrimario;
      color = ssModel.colorPrimario;
    } else {
      tamano = ssModel.bulletSecundario;
      color = ssModel.colorSecundario;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: tamano,
      height: tamano,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class _Slides extends StatefulWidget {
  final List<Widget> slides;
  const _Slides(this.slides);

  @override
  State<_Slides> createState() => _SlidesState();
}

class _SlidesState extends State<_Slides> {
  final pageViewController = PageController();

  @override
  void initState() {
    super.initState();
    pageViewController.addListener(() {
      Provider.of<_SlideshowModel>(context, listen: false).currentPage =
          pageViewController.page!;
    });
  }

  @override
  void dispose() {
    pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageViewController,
      children: widget.slides.map((slide) => _Slide(slide)).toList(),
    );
  }
}

class _Slide extends StatelessWidget {
  final Widget slide;
  const _Slide(this.slide);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(10),
      child: slide,
    );
  }
}

class _SlideshowModel with ChangeNotifier {
  double _currentPage = 0;
  Color colorPrimario = Colors.blue;
  Color colorSecundario = Colors.grey;
  double bulletPrimario = 12;
  double bulletSecundario = 12;

  double get currentPage => _currentPage;
  set currentPage(double pagina) {
    _currentPage = pagina;

    notifyListeners();
  }
}
