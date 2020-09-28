import 'package:flutter/material.dart';

class PitchInformationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[800],
        title: Text('Мини футбольное поле')
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 220,
              child: ImageCarousel()
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Container(
                    child: Text(
                      'Мини футбольное поле',
                      style: TextStyle(
                        fontSize: 20
                      )
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    child: Text('Есть два поля, ворота, все как положено, чики пуки. Есть два поля, ворота, все как положено, чики пуки. Есть два поля, ворота, все как положено, чики пуки. Есть два поля, ворота, все как положено, чики пуки. Есть два поля, ворота, все как положено, чики пуки. Есть два поля, ворота, все как положено, чики пуки.')
                  )
                ],
              )
            )
          ]
        ),
      )
    );
  }
}

class ImageCarousel extends StatefulWidget {
  @override
  _ImageCarouselState createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  PageController pageController;
  List<String> images = [
    'https://i.pinimg.com/474x/98/e2/50/98e250ec387ad722631735e33246565b.jpg',
    'https://sxodim.com/uploads/shymkent/2016/07/unnamed-745x425.jpg',
    'https://aif-s3.aif.ru/images/007/492/d41314c761174fefa6df793fa8f41780.jpg',
    'https://img.lovepik.com/photo/50091/3009.jpg_wh860.jpg'
  ];

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PageView.builder(
        controller: pageController,
        itemCount: images.length,
        itemBuilder: (context, position) {
          return Container(
            child: imageSlider(position)
          );
        },
      )
    );
  }

  imageSlider(int index) {
    return AnimatedBuilder(
      animation: pageController,
      child: FadeInImage(
        width: double.infinity,
        fit: BoxFit.cover,
        image: NetworkImage(
          images[index],
        ),
        placeholder: AssetImage('assets/images/image-loading.gif'),
      ),
      builder: (context, widget) {
        return Container(
          child: widget
        );
      }
    );
  }
}
