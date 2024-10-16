import 'package:flutter/material.dart';
import 'package:sea/constants/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
final List<Widget>? action;
  const CustomAppBar({super.key, required this.title, this.action });

  @override
  Widget build(BuildContext context) {
    return  AppBar(

      automaticallyImplyLeading: true,
      leading: Text(''),
      title: Text(title, style: const  TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
      centerTitle: true,
      actions: action,
      backgroundColor:  Colours.kGreenColor,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
