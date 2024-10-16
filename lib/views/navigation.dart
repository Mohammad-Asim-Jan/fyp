import 'package:flutter/material.dart';
import 'package:sea/constants/colors.dart';
import 'package:sea/constants/hide_snackbar.dart';
import 'package:sea/views/bill_page_view.dart';
import 'package:sea/views/Reading/readings_view.dart';
import 'package:sea/views/Statistics/statistics_view.dart';
import 'Home/home_view.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int myIndex = 0;

  List<Widget> widgetList = [
    const Home(),
    const Readings(),
    const BillPageView(),
    const Statistics(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          // Center(child: widgetList[myIndex],),
          IndexedStack(
        index: myIndex,
        children: widgetList,
      ),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colours.kGreenColor,
          onTap: (index) {
            setState(() {
              myIndex = index;
            });
            if (index != 1) {
              scaffoldMessengerKey.currentState?.clearSnackBars();
            }
          },
          currentIndex: myIndex,
          unselectedItemColor: Colors.black,
          selectedItemColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),

            BottomNavigationBarItem(
                icon: Icon(Icons.graphic_eq_sharp), label: 'Readings'),
            BottomNavigationBarItem(icon: Icon(Icons.receipt), label: 'Bill'),
            BottomNavigationBarItem(
                icon: Icon(Icons.stacked_bar_chart_outlined),
                label: 'Statistics'),
          ]),
    );
  }
}
