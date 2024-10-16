import 'package:flutter/material.dart';
import 'package:sea/constants/colors.dart';

class CustomButton extends StatelessWidget {

 final String btnText;
 final double btnHeight;
 final double btnWidth;
 final void Function() onPress;

  const CustomButton({super.key, required this.btnText , required this.btnHeight, required this.btnWidth, required this.onPress });



  @override
  Widget build(BuildContext context) {

    return MaterialButton(
      height: btnHeight,
        minWidth: btnWidth,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)),
        color: Colours.kGreenColor,
        onPressed: onPress,
        child:   Text(btnText, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold,),),
    );





    // MaterialButton(
    //   minWidth: 250,
    //   height: 40,
    //   shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(10)),
    //   color: const Color(0XFF24AD5F),
    //   onPressed: pickedImage != null
    //       ? () {
    //     if (pickedImage != null) {
    //       getData(pickedImage);
    //     }
    //   }
    //       : () {
    //     showSnackBar('Please Upload Image First');
    //     // showDialog(
    //     //   context: context,
    //     //   builder: (BuildContext context) {
    //     //     return
    //     //   AlertDialog(
    //     //   title: const Text(
    //     //     'Warning',
    //     //     style: TextStyle(color: Colors.red),
    //     //   ),
    //     //   content:
    //     //   const Text('Please Select Image First'),
    //     //   actions: [
    //     //     TextButton(
    //     //       onPressed: () {
    //     //         Navigator.pop(context);
    //     //       },
    //     //       child: const Text('OK'),
    //     //     ),
    //     //   ],
    //     // );
    //     //   },
    //     // );
    //   },
    //   child: const Text(
    //     'Extract Units',
    //     style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,),
    //   ),
    // ),






  }
}
