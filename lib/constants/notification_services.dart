import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../views/message_screen.dart';

class NotificationServices {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  void initializeNotifications(BuildContext context) async {
    var androidInitializationSettings =
    const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (payload) {
        handleNotificationClick(context);
      },
    );

    // Check for any initial notification payload
    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
    await _flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      handleNotificationClick(context);
    }
  }

  Future<void> showNotification(
      {required String title, required String body}) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      Random.secure().nextInt(100000).toString(),
      'High Importance Notification',
      importance: Importance.max,
    );
    AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
      channel.id.toString(),
      channel.name.toString(),
      channelDescription: 'Your Channel Description',
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    await _flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      notificationDetails,
    );
  }

  void handleNotificationClick(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MessageScreen()),
    );
  }
}
