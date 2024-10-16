
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../views/login/login_provider.dart';
import 'colors.dart';



class PasswordTextField extends StatelessWidget {
  final TextEditingController controller;

  const PasswordTextField({
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);


    return TextField(
      obscureText: loginProvider.obscureText,
      controller: controller,

      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold,),
      decoration: InputDecoration(
          hintText: 'Enter Password',
          filled: true,
          fillColor: Colours.kContainerColor,
          contentPadding: const EdgeInsets.all(10),
          suffixIcon: GestureDetector(
              onTap: () {
                loginProvider.changeVisibility();
              },
              child: Icon(loginProvider.obscureText
                  ? Icons.visibility_off
                  : Icons.visibility, color: Colors.grey,)),
          // constraints: BoxConstraints(
          //     maxWidth: widthX * 0.9, maxHeight: heightX * 0.08),
          hintStyle: const TextStyle(
            color: Colors.white54, fontSize: 13, fontWeight: FontWeight.bold,),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:  const BorderSide(
                  color: Colors.white, width: 2.0),),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:  const BorderSide(
                  color: Colors.white, width: 2.0),)),
    );
  }
}