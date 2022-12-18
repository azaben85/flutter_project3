import 'dart:io';

import 'package:firebase_app/admin/views/screens/widgets/image_source_widget.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {
  ImagePickerHelper._();
  static ImagePickerHelper imagePickerHelper = ImagePickerHelper._();

  Future<File?> pickImageFromGallery() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  Future<File?> pickImageFromCamera() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  Future<List<ImageSourceWidget>?> pickMultiImageFromGallery() async {
    List<XFile> pickedFiles = await ImagePicker().pickMultiImage();
    if (pickedFiles != null) {
      return pickedFiles.map((e) {
        return ImageSourceWidget(e.path);
      }).toList();
    }
    return null;
  }
}
