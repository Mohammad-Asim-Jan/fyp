import 'package:flutter/material.dart';
import 'package:sea/constants/colors.dart';

void showImageSourceDialog(BuildContext context, {VoidCallback? onCameraTap, VoidCallback? onGalleryTap}) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            padding: const EdgeInsets.all(20),
            height: 150,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    onCameraTap?.call();
                    Navigator.of(context).pop(); // Hide bottom sheet after camera tap
                  },
                  child: Card(
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(color:Colours.kGreenColor,),
                      child: const Text(
                        'Camera',
                        style: TextStyle(color: Colors.white,fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                GestureDetector(
                  onTap: () {
                    onGalleryTap?.call();
                    Navigator.of(context).pop(); // Hide bottom sheet after gallery tap
                  },
                  child: Card(
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(color: Colours.kGreenColor,),
                      child: const Text(
                        'Gallery',
                        style: TextStyle(color: Colors.white,fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
