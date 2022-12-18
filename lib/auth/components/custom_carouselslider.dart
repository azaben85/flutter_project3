import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_app/admin/views/screens/widgets/image_source_widget.dart';
import 'package:flutter/material.dart';

class CustomeCarouselSlider extends StatefulWidget {
  List<ImageSourceWidget> selectImages = [];

  CustomeCarouselSlider(this.selectImages);

  @override
  State<CustomeCarouselSlider> createState() => _CustomeCarouselSliderState();
}

class _CustomeCarouselSliderState extends State<CustomeCarouselSlider> {
  int imageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CarouselSlider(
        options: CarouselOptions(
            onPageChanged: (index, reason) {
              imageIndex = index;
              setState(() {});
            },
            height: 250.0,
            autoPlay: true,
            viewportFraction: 1),
        items: widget.selectImages.map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration:
                      BoxDecoration(color: Color.fromARGB(255, 184, 178, 178)),
                  child: i);
            },
          );
        }).toList(),
      ),
      const SizedBox(
        height: 10,
      ),
      Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.selectImages.length, (index) {
            if (imageIndex == index) {
              return const Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Icon(
                  Icons.circle,
                  size: 14,
                  color: Colors.green,
                ),
              );
            }
            return const Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: Icon(
                Icons.circle,
                size: 8,
              ),
            );
          }))
    ]);
  }
}
