import 'package:firebase_app/admin/views/screens/widgets/image_source_widget.dart';
import 'package:flutter/material.dart';

class CarImages extends StatelessWidget {
  List<ImageSourceWidget> selectImages;
  CarImages({
    Key? key,
    required this.selectImages,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemCount: selectImages.length,
        itemBuilder: (context, index) {
          return selectImages[index];
        });
  }
}
