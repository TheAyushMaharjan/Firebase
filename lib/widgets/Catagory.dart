import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Catagory extends StatelessWidget {
  const Catagory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CarouselSlider.builder(
        itemCount: 8,
        options: CarouselOptions(
          height: 50,
          viewportFraction: 0.2,
          pageSnapping: true,
          enableInfiniteScroll: false,
          initialPage: 0,
        ),
        itemBuilder: (context, itemIndex, pageViewIndex) {
          return ClipOval(
            child: Container(
              height: 50,
              width: 50,
              color: Colors.greenAccent,
            ),
          );
        },
      ),
    );
  }
}
