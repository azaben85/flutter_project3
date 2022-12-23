import 'package:flutter/material.dart';

class DisplayImages extends StatelessWidget {
  List<String> imageUrls;
  DisplayImages(
    this.imageUrls,
  );

  @override
  Widget build(BuildContext context) {
    List<Image> images =
        imageUrls.getRange(0, imageUrls.length > 4 ? 4 : imageUrls.length).map(
      (e) {
        return Image.network(e);
      },
    ).toList();
    return SizedBox(
      height: 200,
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Expanded(child: images[0]),
          if (images.length > 1)
            SizedBox(
              width: 100,
              height: 199,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: images
                    .getRange(1, images.length)
                    .map((e) => SizedBox(height: 59, child: e))
                    .toList(),
              ),
            )
        ],
      ),
    );
  }
}
