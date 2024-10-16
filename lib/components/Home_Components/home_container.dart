import 'package:flutter/material.dart';
import 'package:sea/constants/colors.dart';
import 'package:sea/utils/screen_size.dart';

class HomeContainer extends StatelessWidget {
final int numValue;
final String unit;
final String unitValue;
  const HomeContainer({required this.numValue, required this.unit, required this.unitValue, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: screenHeight(context) * 0.19,
      width: screenWidth(context) * 0.4,
      decoration: BoxDecoration(
        color:  Colours.kContainerColor,
        borderRadius: BorderRadius.circular(25),
      ),
      child:   Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(numValue.toString(),
                style: const TextStyle(
                    color: Colours.kGreenColor,
                    fontSize: 52,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 5,
              ),
                Text(
                unit,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
            Text(
            unitValue,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
