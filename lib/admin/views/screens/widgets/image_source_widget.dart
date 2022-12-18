import 'dart:io';

import 'package:flutter/material.dart';

class ImageSourceWidget extends StatelessWidget {
  Image? image;
  String imageURL;
  String? source;
  File? file;
  ImageSourceWidget(this.imageURL, {this.image, this.source = 'File'});

  @override
  Widget build(BuildContext context) {
    if (source == 'Network') {
      return Image.network(imageURL);
    }
    file = File(imageURL);
    return Image.file(file!);
  }
}
