// ignore_for_file: empty_catches

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cehpoint_marketplace_seller/common/plain_text.dart';
import 'dart:async';

// ignore: must_be_immutable
class NotificationProperty extends StatefulWidget {
  String email = "";
  NotificationProperty({super.key, required this.email});

  @override
  State<NotificationProperty> createState() => _NotificationPropertyState();
}

class _NotificationPropertyState extends State<NotificationProperty> {
  int count = -1;
  // ignore: unused_field
  late Timer _timer;
  late CollectionReference<Map<String, dynamic>> collectionReference;
  late QuerySnapshot<Map<String, dynamic>> querySnapshot;
  Map<String, dynamic> docIdFieldValueMap = {};

  @override
  void initState() {
    super.initState();
    fetchNotifications();
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) async {
      await fetchDocIdFieldValueMap();
      await fetchNotifications();
    });
  }

  Future<void> fetchNotifications() async {
    try {
      setState(() async {
        collectionReference = FirebaseFirestore.instance
            .collection('users')
            .doc(widget.email)
            .collection('Seller_Property_Notification');
        querySnapshot = await collectionReference.get();
        count = querySnapshot.size;
      });
    } catch (e) {
      if (kDebugMode) {
        debugPrint("CATCHED ERROR : $e");
      }
    }
  }

  Future<void> fetchDocIdFieldValueMap() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshotss =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(widget.email)
              .collection('Seller_Property')
              .get();
      for (QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshotss
          in querySnapshotss.docs) {
        String docId = documentSnapshotss.id;
        Map<String, dynamic> map = documentSnapshotss.data();
        String fieldValue = map['Images'][0];

        // Add the entry to the map
        setState(() {
          docIdFieldValueMap[docId] = fieldValue;
        });
      }
    } catch (error) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 205, 205, 205),
      appBar: AppBar(
        backgroundColor: const Color(0xFF08215E),
        title: Row(
          children: [
            const SizedBox(width: 10),
            PlainText(
              name:
                  (count == -1) ? "Notifications(0)" : "Notifications($count)",
              fontsize: 20,
              color: Colors.white,
            ),
          ],
        ),
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: (count == -1) ? 0 : count,
            itemBuilder: (context, index) {
              QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot =
                  querySnapshot.docs[index];
              Map<String, dynamic> data = documentSnapshot.data();
              String title = data['Title'];
              String docID = data['docID'];
              String description = data['Description'];
              Timestamp dateTS = data['Date'];
              String date = "";
              String avatarURL =
                  "https://firebasestorage.googleapis.com/v0/b/msoko-seller.appspot.com/o/avatar%2FAvatar_Property.png?alt=media&token=571a9f00-0f39-416a-a00e-8cd1aa592ca9";
              if (docIdFieldValueMap.containsKey(docID)) {
                avatarURL = docIdFieldValueMap[docID];
              }
              if (isToday(dateTS)) {
                date = "Today";
              } else if (isYesterday(dateTS)) {
                date = "Yesterday";
              } else {
                date = formatTimestamp(dateTS);
              }
              return ListTile(
                contentPadding: const EdgeInsets.fromLTRB(7, 0, 7, 0),
                title: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.notifications,
                            size: 21,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            title,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 5,
                          ),
                          const Icon(
                            Icons.circle,
                            size: 9,
                            color: Colors.green,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            date,
                            style: const TextStyle(
                                fontSize: 15, color: Colors.green),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: Image.network(
                              avatarURL,
                              height: 50,
                              width: 50,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Flexible(
                            flex: 3,
                            child: Text(
                              description,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          if (count == -1)
            Center(
              child: Container(),
            ),
          if (count == 0)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }

  String formatTimestamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    String formattedDate =
        "${dateTime.day} ${_getMonth(dateTime.month)}, ${dateTime.year}";
    return formattedDate;
  }

  String _getMonth(int month) {
    switch (month) {
      case 1:
        return "January";
      case 2:
        return "February";
      case 3:
        return "March";
      case 4:
        return "April";
      case 5:
        return "May";
      case 6:
        return "June";
      case 7:
        return "July";
      case 8:
        return "August";
      case 9:
        return "September";
      case 10:
        return "October";
      case 11:
        return "November";
      case 12:
        return "December";
      default:
        return "";
    }
  }

  bool isSameDate(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  bool isToday(Timestamp timestamp) {
    DateTime currentDate = DateTime.now();
    DateTime dateFromTimestamp = timestamp.toDate();
    return isSameDate(currentDate, dateFromTimestamp);
  }

  bool isYesterday(Timestamp timestamp) {
    DateTime yesterdayDate = DateTime.now().subtract(const Duration(days: 1));
    DateTime dateFromTimestamp = timestamp.toDate();
    return isSameDate(yesterdayDate, dateFromTimestamp);
  }
}
