import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:sea/utils/screen_size.dart';

class ImageCarousel extends StatefulWidget {
  const ImageCarousel({super.key});

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {

  List imageList = [
    Image.asset('assets/images/Carousel1.jpg', fit: BoxFit.cover),
    Image.asset('assets/images/Carousel2.jpg', fit: BoxFit.cover),
    Image.asset('assets/images/Carousel3.jpg', fit: BoxFit.cover),
    Image.asset('assets/images/Carousel4.jpg', fit: BoxFit.cover),
    Image.asset('assets/images/Carousel5.jpg', fit: BoxFit.cover),
    Image.asset('assets/images/Carousel6.jpg', fit: BoxFit.cover),
  ];

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: ListView(shrinkWrap: true,
        reverse: true,
        children: [
        SizedBox(
          height: screenHeight(context)*0.35,
          width: double.infinity,
          child: AnotherCarousel(
              dotColor: Colors.white ,
              dotIncreasedColor: const Color(0XFF24AD5F),
              dotIncreaseSize: 1.5,
              dotSpacing: 15,
              images:  imageList,
          ),
        ),
      ],),
    );

  }
}
