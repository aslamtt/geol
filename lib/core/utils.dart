import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:geol/core/providers/utils.dart';
import 'package:image_picker/image_picker.dart';
final ImagePicker _picker = ImagePicker();

Future<FilePickerResult?> pickImage() async {
  final image = await FilePicker.platform.pickFiles(
    type: FileType.image,
  );

  return image;
}

Future<XFile?> pickImg(BuildContext context) async {
  final XFile? pickedFile = await _picker.pickImage(
    source: ImageSource.gallery,
    imageQuality: 80,
  );

  if (pickedFile != null) {
    final File imageFile = File(pickedFile.path);
    final int imageSizeBytes = await imageFile.length();
    final double imageSizeKB = imageSizeBytes / 1024; // Convert bytes to KB

    // Set your maximum image size limit (e.g., 1024 KB or 1 MB)
    const double maxImageSizeKB = 500;
    // You can now check the image size against the maximum limit
    if (imageSizeKB > maxImageSizeKB) {
      showSnackBar(
          context, "Image size is too large,Please upload another image");

      if (kDebugMode) {
        print("toooooo large");
      }
      // Image size is too large
      return null; // or handle the error in your own way
    }

    return pickedFile;
  }

  return null; // No image was picked
}

String leadingTimeFormat(int leadingTime) {
  String formattedTime = leadingTime < 60
      ? '$leadingTime Min'
      : '${leadingTime ~/ 60} hour${leadingTime ~/ 60 != 1 ? 's' : ''}${leadingTime % 60 != 0 ? ' ${leadingTime % 60} mins' : ''}';
  return formattedTime;
}
