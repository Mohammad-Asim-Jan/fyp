import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sea/components/home_components/home_container.dart';
import 'package:sea/components/home_components/image_carousel.dart';
import 'package:sea/constants/custom_appbar.dart';
import 'package:sea/constants/notification_services.dart';
import 'package:sea/utils/constant.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  NotificationServices notificationServices = NotificationServices();


  @override
  void initState() {
    super.initState();
    _startListeningToDatabase();
    notificationServices.initializeNotifications(context);
  }

  void _startListeningToDatabase() {
    DatabaseReference dbRef = FirebaseDatabase.instance.ref();

    // Listen for changes in the database
    _listenToValueChanges(dbRef.child('voltage'), (value) {
      setState(() {
        TConstant.voltage = _parseInt(value);
      });
      _checkVoltage();
    });

    _listenToValueChanges(dbRef.child('current'), (value) {
      setState(() {
        TConstant.current = _parseInt(value);
      });
    });

    _listenToValueChanges(dbRef.child('humidity'), (value) {
      setState(() {
        TConstant.humidity = _parseInt(value);
      });
    });

    _listenToValueChanges(dbRef.child('temp'), (value) {
      setState(() {
        TConstant.temp = _parseInt(value);
        print(TConstant.temp);
      });
      _checkTemperature();
    });
  }

  void _listenToValueChanges(
      DatabaseReference ref, Function(dynamic) onChange) {
    ref.onValue.listen((event) {
      final newValue = event.snapshot.value;
      print('New value from database: $newValue');
      onChange(newValue);
    });
  }

  int _parseInt(dynamic value) {
    if (value is int) {
      print('int');
      return value;
    } else if (value is String) {
      print('string');
      return int.tryParse(value) ?? 0;
    } else if (value is double) {
      print('double');
      print(value.toInt());
      return value.toInt();
    } else {
      return 0; // Default value in case of unknown type
    }
  }

  void _checkTemperature() {
    if (TConstant.temp >= 50) {
      notificationServices.showNotification(
        title: 'High Temperature Alert',
        body: 'The temperature is above 50!',
      );
    }
  }

  void _checkVoltage() {
    print('uuuuuuuuuuuuuuuuuuuu ${TConstant.voltage}');
    if (TConstant.voltage >= 250) {
      notificationServices.showNotification(
        title: 'High Voltage Alert',
        body: 'The temperature is above 250!',
      );
    }
  }

  Widget content(BuildContext context) {
    return Column(
      children: [
        const Center(
          child: ImageCarousel(),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  HomeContainer(
                      numValue: TConstant.voltage,
                      unit: 'V',
                      unitValue: 'Voltage'),
                  const SizedBox(
                    width: 20,
                  ),
                  HomeContainer(
                      numValue: TConstant.current,
                      unit: 'I',
                      unitValue: 'Current'),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  HomeContainer(
                      numValue: TConstant.humidity,
                      unit: '%',
                      unitValue: 'Humidity'),
                  const SizedBox(
                    width: 20,
                  ),
                  HomeContainer(
                      numValue: TConstant.temp,
                      unit: 'C',
                      unitValue: 'Temperature'),
                ],
              ),
            ],
          ),
        ),

      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    print('Voltage: ${TConstant.voltage}');
    print('Current: ${TConstant.current}');
    print('Humidity: ${TConstant.humidity}');
    print('Temperature: ${TConstant.temp}');
    return Scaffold(
      appBar: const CustomAppBar(title: 'SMART ENERGY ASSISTANT'),
      body: content(context),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
