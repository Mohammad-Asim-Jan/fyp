import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sea/constants/custom_appbar.dart';
import 'package:sea/views/Statistics/bill_details_history.dart';

import '../../constants/colors.dart';
import '../login/login_provider.dart';

class Statistics extends StatefulWidget {
  const Statistics({super.key});

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return Scaffold(
        body: Text('data'),
      );
    }
    return Scaffold(
      appBar: CustomAppBar(
        title: 'STATISTICS',
        action: [
          InkWell(
              onTap: () {
                loginProvider.logout(context);
              },
              child: Icon(
                Icons.logout,
                color: Colors.white,
              )),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Bill_Details')
            .where('user_id', isEqualTo: user.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print('error');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.data!.docs.isEmpty) {
            print('Empty');
            return Center(
                child: Text(
              'No Bill Generated Yet',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.white),
            ));
          }
          if (snapshot != null && snapshot.data != null) {
            return Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, right: 8.0, bottom: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BillDetailsHistory(
                                      date: snapshot.data!.docs[index]
                                          ['Reading_Date'],
                                      billMonth: snapshot.data!.docs[index]
                                          ['Bill_Month'],
                                   prevUnits: snapshot.data!.docs[index]['Previous_Units'],
                                  currUnits: snapshot.data!.docs[index]['Current_Units'],
                                  totalUnits: snapshot.data!.docs[index]['Units_Consumed'],
                                   unitsPrice: snapshot.data!.docs[index]['Units_Price'],
                                   tvFee: snapshot.data!.docs[index]['TV_Fee'],
                                currBill: snapshot.data!.docs[index]['Current_Bill'],
                                  fcSur: snapshot.data!.docs[index]['FC_SUR'],
                                  ed: snapshot.data!.docs[index]['Electricity_Duty'],
                                  cost: snapshot.data!.docs[index]['Total_Cost'],
                                  fpa: snapshot.data!.docs[index]['Total_FPA'],
                                  GST: snapshot.data!.docs[index]['GST'],
                                   Qtr: snapshot.data!.docs[index]['Annual_QTR'],
                                    )));
                      },
                      child: Card(
                        color: Colours.kGreenColor,
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Text(
                              '${index + 1}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          title: Text(
                            'Bill Month: ${snapshot.data!.docs[index]['Bill_Month']}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          subtitle: Text(
                            'Total Bill: ${snapshot.data!.docs[index]['Current_Bill']}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          trailing: Icon(
                            Icons.more_vert,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}

// import 'package:firebase_database/firebase_database.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sea/constants/colors.dart';
// import 'package:sea/constants/custom_appbar.dart';
// import 'package:sea/constants/custom_button.dart';
// import 'package:sea/utils/constant.dart';
// import 'package:sea/utils/screen_size.dart';
// import 'package:sea/views/login/login_provider.dart';
//
// class Statistics extends StatefulWidget {
//   const Statistics({super.key});
//
//   @override
//   State<Statistics> createState() => _StatisticsState();
// }
//
// class _StatisticsState extends State<Statistics> {
//   @override
//   void initState() {
//     super.initState();
//     _startListeningToDatabase();
//   }
//
//   void _startListeningToDatabase() {
//     DatabaseReference dbRef = FirebaseDatabase.instance.ref();
//
//     // Listen for changes in the database
//     _listenToValueChanges(dbRef.child('voltage'), (value) {
//       setState(() {
//         TConstant.voltage = _parseInt(value);
//       });
//     });
//
//     _listenToValueChanges(dbRef.child('current'), (value) {
//       setState(() {
//         TConstant.current = _parseInt(value);
//       });
//     });
//
//     _listenToValueChanges(dbRef.child('power'), (value) {
//       setState(() {
//         TConstant.humidity = _parseInt(value);
//       });
//     });
//
//     _listenToValueChanges(dbRef.child('temp'), (value) {
//       setState(() {
//         TConstant.temp = _parseInt(value);
//       });
//     });
//   }
//
//   void _listenToValueChanges(
//       DatabaseReference ref, Function(dynamic) onChange) {
//     ref.onValue.listen((event) {
//       onChange(event.snapshot.value);
//     });
//   }
//
//   int _parseInt(dynamic value) {
//     if (value is int) {
//       return value;
//     } else if (value is String) {
//       return int.tryParse(value) ?? 0;
//     } else {
//       return 0; // Default value in case of unknown type
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final loginProvider = Provider.of<LoginProvider>(context);
//     return Scaffold(
//       appBar:   CustomAppBar(
//         title: 'STATISTICS',
//         action: [
//           InkWell(
//             onTap : (){
//               loginProvider.logout(context);
//             },
//               child: Icon(Icons.logout, color: Colors.white,)),
//           SizedBox(
//             width: 20,
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           children: [
//             const SizedBox(height: 10),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 CustomButton(
//                     btnText: 'Last 30 days',
//                     btnHeight: screenHeight(context) * 0.053,
//                     btnWidth: screenWidth(context) * 0.42,
//                     onPress: () {}),
//                 const SizedBox(width: 10),
//                 CustomButton(
//                     btnText: 'Last 12 months',
//                     btnHeight: screenHeight(context) * 0.053,
//                     btnWidth: screenWidth(context) * 0.42,
//                     onPress: () {}),
//               ],
//             ),
//             const SizedBox(height: 20),
//             const Align(
//               alignment: Alignment.centerLeft,
//               child: Text(
//                 'Breakdown Per Day',
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 17,
//                     fontWeight: FontWeight.bold),
//               ),
//             ),
//             const SizedBox(height: 20),
//             Expanded(
//               child: BarChart(
//                 BarChartData(
//                   gridData: const FlGridData(show: false),
//                   alignment: BarChartAlignment.spaceAround,
//                   maxY: 24,
//                   barGroups: _getBarGroups(),
//                   borderData: FlBorderData(
//                     show: false,
//                   ),
//                   titlesData: FlTitlesData(
//                     topTitles: const AxisTitles(
//                       sideTitles: SideTitles(showTitles: false),
//                     ),
//                     leftTitles: AxisTitles(
//                       axisNameWidget: const Text(
//                         'Hours',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 15,
//                         ),
//                       ),
//                       sideTitles: SideTitles(
//                         showTitles: true,
//                         reservedSize: 30,
//                         interval: 5,
//                         getTitlesWidget: (value, meta) {
//                           return Text(
//                             value.toInt().toString(),
//                             textAlign: TextAlign.center,
//                             style: const TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 15,
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                     bottomTitles: AxisTitles(
//                       axisNameWidget: const Text(
//                         'Days',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 15,
//                         ),
//                       ),
//                       sideTitles: SideTitles(
//                         showTitles: true,
//                         reservedSize: 40,
//                         getTitlesWidget: (value, meta) {
//                           switch (value.toInt()) {
//                             case 0:
//                               return const Padding(
//                                 padding: EdgeInsets.all(3.0),
//                                 child: Text(
//                                   "1 Jul",
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 15,
//                                   ),
//                                 ),
//                               );
//                             case 10:
//                               return const Padding(
//                                 padding: EdgeInsets.all(3.0),
//                                 child: Text(
//                                   "10 Jul",
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 15,
//                                   ),
//                                 ),
//                               );
//                             case 20:
//                               return const Padding(
//                                 padding: EdgeInsets.all(3.0),
//                                 child: Text(
//                                   "20 Jul",
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 15,
//                                   ),
//                                 ),
//                               );
//                             case 30:
//                               return const Padding(
//                                 padding: EdgeInsets.all(3.0),
//                                 child: Text(
//                                   "31 Jul",
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 15,
//                                   ),
//                                 ),
//                               );
//                             default:
//                               return const Padding(
//                                 padding: EdgeInsets.all(3.0),
//                                 child: Text(""),
//                               );
//                           }
//                         },
//                       ),
//                     ),
//                     rightTitles: const AxisTitles(
//                       sideTitles: SideTitles(showTitles: false),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             const Text(
//               'Day vs. Night',
//               style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white),
//             ),
//             const SizedBox(height: 10),
//             Expanded(
//               child: PieChart(
//                 PieChartData(
//                   sections: _getPieChartSections(),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   List<BarChartGroupData> _getBarGroups() {
//     List<BarChartGroupData> barGroups = [];
//     for (int i = 0; i < 31; i++) {
//       barGroups.add(
//         BarChartGroupData(
//           x: i,
//           barRods: [
//             BarChartRodData(
//               color: Colours.kGreenColor,
//               toY: i % 2 == 0 ? 12 : 8,
//             ),
//           ],
//         ),
//       );
//     }
//     return barGroups;
//   }
//
//   List<PieChartSectionData> _getPieChartSections() {
//     return [
//       PieChartSectionData(
//         color: Colours.kGreenColor,
//         value: 60,
//         title: 'Day',
//         radius: 50,
//         titleStyle: const TextStyle(
//             fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
//       ),
//       PieChartSectionData(
//         color: Colors.white,
//         value: 40,
//         title: 'Night',
//         radius: 50,
//         titleStyle: const TextStyle(
//             fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
//       ),
//     ];
//   }
// }
