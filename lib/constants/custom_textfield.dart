import 'package:flutter/material.dart';
import 'package:sea/constants/colors.dart';

class CustomTextField extends StatelessWidget {
  final  TextEditingController controller;
  final String hintText;
  final Widget? suffix;
  final bool read;
  final TextInputType? keyboardType;
 final  void Function()onPress;
  const CustomTextField({ super.key,
     this.suffix,
    required this.controller, required this.hintText, required this.read, required this.onPress, this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return TextField(

      controller: controller,
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold,),
      // maxLines: null,
      keyboardType: keyboardType,

      decoration: InputDecoration(
        suffixIcon: suffix,
        filled: true,
        fillColor: Colours.kContainerColor,
        contentPadding: const EdgeInsets.all(10),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
              color: Colors.white, width: 2.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
              color: Colors.white, width: 2.0),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.white54, fontSize: 13, fontWeight: FontWeight.bold,),
      ),
      readOnly: read,
      onTap: onPress,
    );



    // TextField(
    //   controller: pResponseController,
    //   style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold,),
    //   maxLines: null,
    //   keyboardType: TextInputType.number,
    //   decoration: InputDecoration(
    //     filled: true,
    //     fillColor: const Color(0XFF26272B),
    //     contentPadding: const EdgeInsets.all(10),
    //     enabledBorder: OutlineInputBorder(
    //       borderRadius: BorderRadius.circular(10.0),
    //       borderSide: const BorderSide(
    //           color: Colors.white, width: 2.0),
    //     ),
    //     focusedBorder: OutlineInputBorder(
    //       borderRadius: BorderRadius.circular(10.0),
    //       borderSide: const BorderSide(
    //           color: Colors.white, width: 2.0),
    //     ),
    //     hintText: 'Enter Previous Units',
    //     hintStyle: const TextStyle(
    //       color: Colors.white54, fontSize: 13, fontWeight: FontWeight.bold,),
    //   ),
    // ),

  }
}
