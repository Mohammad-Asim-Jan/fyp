import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sea/constants/colors.dart';
import 'package:sea/constants/custom_appbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class Readings extends StatefulWidget {
  const Readings({super.key});

  @override
  _ReadingsState createState() => _ReadingsState();
}

class _ReadingsState extends State<Readings> {
  List<FlSpot> voltageData = [];
  List<FlSpot> currentData = [];
  List<FlSpot> powerData = [];
  List<FlSpot> tempData = [];

  bool showVoltage = true;
  bool showCurrent = false;
  bool showPower = false;
  bool showTemp = false;

  StreamSubscription<DatabaseEvent>? voltageSubscription;
  StreamSubscription<DatabaseEvent>? currentSubscription;
  StreamSubscription<DatabaseEvent>? powerSubscription;
  StreamSubscription<DatabaseEvent>? tempSubscription;

  @override
  void initState() {
    super.initState();
    _loadData();
    _startListening();
  }

  @override
  void dispose() {
    voltageSubscription?.cancel();
    currentSubscription?.cancel();
    powerSubscription?.cancel();
    tempSubscription?.cancel();
    super.dispose();
  }

  Future<void> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      voltageData = _getDataFromPrefs(prefs, 'voltageData');
      currentData = _getDataFromPrefs(prefs, 'currentData');
      powerData = _getDataFromPrefs(prefs, 'powerData');
      tempData = _getDataFromPrefs(prefs, 'tempData');
    });
  }

  List<FlSpot> _getDataFromPrefs(SharedPreferences prefs, String key) {
    List<String>? dataString = prefs.getStringList(key);
    if (dataString == null) return [];
    return dataString.map((e) {
      var split = e.split(',');
      return FlSpot(double.parse(split[0]), double.parse(split[1]));
    }).toList();
  }

  Future<void> _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('voltageData', _convertDataToString(voltageData));
    prefs.setStringList('currentData', _convertDataToString(currentData));
    prefs.setStringList('powerData', _convertDataToString(powerData));
    prefs.setStringList('tempData', _convertDataToString(tempData));
  }

  List<String> _convertDataToString(List<FlSpot> data) {
    return data.map((e) => '${e.x},${e.y}').toList();
  }

  void _startListening() {
    DatabaseReference dbRef = FirebaseDatabase.instance.ref();

    if (showVoltage) {
      voltageSubscription = dbRef.child('voltage').onValue.listen((event) {
        final value = event.snapshot.value;
        print(value);
        setState(() {
          voltageData.add(FlSpot(
            DateTime.now().millisecondsSinceEpoch.toDouble(),
            _toDouble(value),
          ));
          _saveData();
        });
      });
    }

    if (showCurrent) {
      currentSubscription = dbRef.child('current').onValue.listen((event) {
        final value = event.snapshot.value;
        print(value);
        setState(() {
          currentData.add(FlSpot(
            DateTime.now().millisecondsSinceEpoch.toDouble(),
            _toDouble(value),
          ));
          _saveData();
        });
      });
    }

    if (showPower) {
      powerSubscription = dbRef.child('humidity').onValue.listen((event) {
        final value = event.snapshot.value;
        print(value);
        setState(() {
          powerData.add(FlSpot(
            DateTime.now().millisecondsSinceEpoch.toDouble(),
            _toDouble(value),
          ));
          _saveData();
        });
      });
    }

    if (showTemp) {
      tempSubscription = dbRef.child('temp').onValue.listen((event) {
        final value = event.snapshot.value;
        print(value);
        setState(() {
          tempData.add(FlSpot(
            DateTime.now().millisecondsSinceEpoch.toDouble(),
            _toDouble(value),
          ));
          _saveData();
        });
      });
    }
  }

  double _toDouble(dynamic value) {
    if (value is int) {
      return value.toDouble();
    } else if (value is double) {
      return value;
    } else if (value is String) {
      return double.tryParse(value) ?? 0.0;
    } else {
      return 0.0; // Default value in case of unknown type
    }
  }

  LineChartBarData _buildLineChartBarData(List<FlSpot> data, Color color) {
    return LineChartBarData(
      spots: data,
      isCurved: false,
      color: color,
      barWidth: 2,
      isStrokeCapRound: true,
      belowBarData: BarAreaData(show: true),
      dotData: const FlDotData(show: false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'READINGS'),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: LineChart(
                LineChartData(
                  minY: 0,
                  maxY: 300,
                  gridData: const FlGridData(show: false),
                  titlesData: FlTitlesData(
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    leftTitles: AxisTitles(
                      axisNameWidget: const Text('Values',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),),
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 50, // Add space between left border and titles
                        interval:
                            25,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            value.toInt().toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          );
                        },
                      ),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      axisNameWidget: const Text('Time',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),),
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 900000, // 15 minutes interval
                        getTitlesWidget: (value, meta) {
                          DateTime date = DateTime.fromMillisecondsSinceEpoch(
                              value.toInt());
                          return Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Text(DateFormat('hh:mm a', ).format(date),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),),
                          );
                        },
                      ),
                    ),
                    show: true,
                  ),
                  borderData: FlBorderData(
                    border: const Border(
                      left: BorderSide(color: Colors.white),
                      bottom: BorderSide(color: Colors.white),
                      right: BorderSide(color: Colors.transparent),
                      top: BorderSide(color: Colors.transparent),
                    ),
                    show: true,
                  ),
                  lineBarsData: [
                    if (showVoltage)
                      _buildLineChartBarData(voltageData, Colors.blue),
                    if (showCurrent)
                      _buildLineChartBarData(currentData, Colors.green),
                    if (showPower)
                      _buildLineChartBarData(powerData, Colors.red),
                    if (showTemp)
                      _buildLineChartBarData(tempData, Colors.orange),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Checkbox(
                      value: showVoltage,
                      checkColor: Colors.white,
                      activeColor: Colours.kGreenColor,
                      side: const BorderSide(color: Colors.white, width: 1.5),
                      onChanged: (value) {
                        setState(() {
                          showVoltage = value ?? true;
                          showCurrent = false;
                          showPower = false;
                          showTemp = false;
                          _startListening();
                        });
                      },
                    ),
                    const Text('Voltage', style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),),
                  ],
                ),
                Column(
                  children: [
                    Checkbox(
                      value: showCurrent,
                      checkColor: Colors.white,
                      activeColor: Colours.kGreenColor,
                      side: const BorderSide(color: Colors.white, width: 1.5),
                      onChanged: (value) {
                        setState(() {
                          showCurrent = value ?? true;
                          showVoltage = false;
                          showPower = false;
                          showTemp = false;
                          _startListening();
                        });
                      },
                    ),
                    const Text('Current', style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),),
                  ],
                ),
                Column(
                  children: [
                    Checkbox(
                      value: showPower,
                      checkColor: Colors.white,
                      activeColor: Colours.kGreenColor,
                      side: const BorderSide(color: Colors.white, width: 1.5),
                      onChanged: (value) {
                        setState(() {
                          showPower = value ?? true;
                          showCurrent = false;
                          showVoltage = false;
                          showTemp = false;
                          _startListening();
                        });
                      },
                    ),
                    const Text('Humidity', style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),),
                  ],
                ),
                Column(
                  children: [
                    Checkbox(
                      value: showTemp,
                      checkColor: Colors.white,
                      activeColor: Colours.kGreenColor,
                      side: const BorderSide(color: Colors.white, width: 1.5),
                      onChanged: (value) {
                        setState(() {
                          showTemp = value ?? true;
                          showCurrent = false;
                          showPower = false;
                          showVoltage = false;
                          _startListening();
                        });
                      },
                    ),
                    const Text('Temperature', style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
