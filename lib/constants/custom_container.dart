import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sea/constants/colors.dart';
import 'package:sea/utils/screen_size.dart';

class CustomContainer extends StatefulWidget {


  const CustomContainer({super.key});

  @override
  State<CustomContainer> createState() => _CustomContainerState();
}

class _CustomContainerState extends State<CustomContainer> {

  XFile? pickedImage;
  final TextEditingController pResponseController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: screenHeight(context) * 0.35,
      width: screenWidth(context) * 0.75,
      decoration: BoxDecoration(
        color: pickedImage != null
            ? null
            : Colours.kContainerColor, // Set color when _image is null
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(25),
        image: pickedImage != null
            ? DecorationImage(
          fit: BoxFit.cover,
          image: FileImage(File(pickedImage!.path)),
        )
            : null,
      ),
      child: pickedImage != null
          ? Stack(
        children: [
          Positioned(
            top: 5,
            right: 5,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  pickedImage = null;
                  pResponseController.clear();
                });
              },
              child: const Icon(
                Icons.close,
                color: Colors.red,
                size: 20,
              ),
            ),
          ),
        ],
      )
          : const Text(
        'Upload Meter Picture',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,),
      ),
    );


    // Container(
    //   alignment: Alignment.center,
    //   height: screenHeight(context) * 0.35,
    //   width: screenWidth(context) * 0.75,
    //   decoration: BoxDecoration(
    //     color: pickedImage != null
    //         ? null
    //         : const Color(
    //         0XFF26272B), // Set color when _image is null
    //     border: Border.all(color: Colors.white),
    //     borderRadius: BorderRadius.circular(25),
    //     image: pickedImage != null
    //         ? DecorationImage(
    //       fit: BoxFit.cover,
    //       image: FileImage(File(pickedImage!.path)),
    //     )
    //         : null,
    //   ),
    //   child: pickedImage != null
    //       ? Stack(
    //     children: [
    //       Positioned(
    //         top: 5,
    //         right: 5,
    //         child: GestureDetector(
    //           onTap: () {
    //             setState(() {
    //               pickedImage = null;
    //               pResponseController.clear();
    //             });
    //           },
    //           child: const Icon(
    //             Icons.close,
    //             color: Colors.red,
    //             size: 20,
    //           ),
    //         ),
    //       ),
    //     ],
    //   )
    //       : const Text(
    //     'Upload Meter Picture',
    //     style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,),
    //   ),
    // ),
  }
}
