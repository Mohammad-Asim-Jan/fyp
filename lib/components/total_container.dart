import 'package:flutter/material.dart';
import 'package:sea/constants/colors.dart';
import 'package:sea/utils/screen_size.dart';

class TotalContainer extends StatelessWidget {
  final String text;
  const TotalContainer({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colours.kContainerColor,
          border: Border.all(color: Colors.white, width: 2),
          borderRadius: BorderRadius.circular(10)),
      height: screenHeight(context) * 0.065,
      width: screenWidth(context) * 0.9,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
