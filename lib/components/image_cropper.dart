import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

Future<XFile?> imageCropperView(String? path, BuildContext context) async {
  CroppedFile? croppedFile = await ImageCropper().cropImage(
    sourcePath: path!,
    uiSettings: [
    AndroidUiSettings(
    toolbarTitle: 'Cropper',
    toolbarColor: Colors.deepOrange,
    toolbarWidgetColor: Colors.white,
    aspectRatioPresets: [
      CropAspectRatioPreset.original,
      CropAspectRatioPreset.square,
      CropAspectRatioPreset.ratio3x2,
      CropAspectRatioPreset.original,
      CropAspectRatioPreset.ratio4x3,
      CropAspectRatioPreset.ratio16x9,

    ],
  ),
      IOSUiSettings(
  title: 'Cropper',
  aspectRatioPresets: [
    CropAspectRatioPreset.original,
    CropAspectRatioPreset.square,
    CropAspectRatioPreset.ratio3x2,
      CropAspectRatioPreset.original,
      CropAspectRatioPreset.ratio4x3,
      CropAspectRatioPreset.ratio16x9,


  ],
  ),
      WebUiSettings(
        context: context,
      ),
    // aspectRatioPresets: [
    //   CropAspectRatioPreset.square,
    //   CropAspectRatioPreset.ratio3x2,
    //   CropAspectRatioPreset.original,
    //   CropAspectRatioPreset.ratio4x3,
    //   CropAspectRatioPreset.ratio16x9,
    // ],
    // uiSettings: [
    //   AndroidUiSettings(
    //       toolbarTitle: 'Crop Image',
    //       toolbarColor: Colors.blue,
    //       toolbarWidgetColor: Colors.white,
    //       initAspectRatio: CropAspectRatioPreset.original,
    //
    //       lockAspectRatio: false),
    //   IOSUiSettings(
    //     title: 'Crop Image',
    //   ),
    //   WebUiSettings(
    //     context: context,
    //   ),
    // ],
  ]);
  if (croppedFile != null) {
    log('Image Cropped');
    return XFile(croppedFile.path); // Return a File object
  } else {
    log('Image Not Cropped');
    return null; // Return null if cropping failed
  }
}

