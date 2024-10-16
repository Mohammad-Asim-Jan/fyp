import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const  Expanded(
      child:   Divider(
        color: Colors.white,
        thickness: 2.0,
      ),
    );
  }
}
