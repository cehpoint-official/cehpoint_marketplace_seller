// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cehpoint_marketplace_seller/views/property_pages/SELECTION.dart';

class NotificationTriggerProperty extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationTriggerProperty> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  // final TextEditingController titleController = TextEditingController();
  // final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
    // start
    if (SELECTION.fetchEmail() != "") {
      Stream<QuerySnapshot<Map<String, dynamic>>> notificationStream =
          FirebaseFirestore.instance
              .collection('users')
              // .doc(SELECTION.fetchEmail())
              .doc("omsingh32123@gmail.com")
              .collection('Seller_Property_Notification')
              .snapshots();
      notificationStream.listen((event) {
        if (event.docs.isEmpty) {
          return;
        }
        showNotification(event.docs.last);
      });
    }
    // end
  }

  void showNotification(QueryDocumentSnapshot<Map<String, dynamic>> event) {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      '001',
      'Local Notification',
      channelDescription: 'To send local notification',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    flutterLocalNotificationsPlugin.show(
      01,
      event.get('Title'),
      event.get('Description'),
      notificationDetails,
    );
  }
  // void showNotification( QueryDocumentSnapshot<Map<String,dynamic>> event ) {
  //   if (titleController.text.isEmpty || descriptionController.text.isEmpty) {
  //     return;
  //   }

  //   const AndroidNotificationDetails androidNotificationDetails =
  //       AndroidNotificationDetails(
  //     'SimpleNotificationApp',
  //     'Simple Notification App',
  //     importance: Importance.high,
  //     priority: Priority.high,
  //   );

  //   const NotificationDetails notificationDetails = NotificationDetails(
  //     android: androidNotificationDetails,
  //   );

  //   flutterLocalNotificationsPlugin.show(
  //     0,
  //     titleController.text,
  //     descriptionController.text,
  //     notificationDetails,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Notification App'),
      ),
      body: Container(),
    );
  }
}
